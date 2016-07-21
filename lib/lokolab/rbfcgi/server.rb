# Wrapper for applications in Ruby via "mod_fcgid".
#
# Copyright (c) Krystian Pietruszka <kpietru@lokolab.net>
# License MIT

require 'cgi'
require 'rack/handler/fastcgi'

module LokoLab
  module Rbfcgi
    class Server

      attr_reader :adapter, :app, :options

      def initialize(app = nil, options = {})
        @adapter = Rack::Handler::FastCGI
        @app = app
        @options = options
      end

      def run(app = nil, options = {})
        if !ENV.include?('lokolab.rbfcgi.wrapper') || ENV['lokolab.rbfcgi.wrapper'] == 'off'
          if !app
            app = self.app
          end
          if !options
            options = self.options
          end
          self.adapter.run(app, options)
        end
      end

      def valid_options
        self.adapter.valid_options
      end

      def serve(request, app)
        self.adapter.serve(request, app)
      end

      def send_headers(out, status, headers)
        self.adapter.send_headers(out, status, headers)
      end

      def self.send_body(out, body)
        self.adapter.send_body(out, body)
      end

      def run_for_wrapper(app = 'Rack::PathInfoRewriter')
        FCGI.each do |request|
          $stdout = request.out

          ENV.replace(request.env)

          path = request.env['SCRIPT_FILENAME']

          if !File.readable_real?(path) && File.new(path).size == 0
            cgi = CGI.new()
            puts cgi.header({
              'status' => 'SERVER_ERROR',
              'type' => 'text/plain'
            })
            puts "[RbfcgiError] The file \"#{path}\" is not executable or readable by this process."
            request.finish
          end

          Dir.chdir(File.dirname(path))
          load(path, true)

          if app.is_a?(String) && self._class_exists(app)
            # TODO "eval" to another solution.
            inst = eval(app)
            self.serve(request, inst.new())
          elsif !app.is_a?(String)
            self.serve(request, app)
          else
            request.finish
          end
        end
      end

      protected def _class_exists(app_name)
        cls = Module.const_get(app_name)
        return cls.is_a?(Class)
      rescue NameError => e
        return false
      end
    end
  end
end

