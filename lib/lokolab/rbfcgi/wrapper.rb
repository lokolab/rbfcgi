# Wrapper for applications in Ruby via "mod_fcgid".
#
# Copyright (c) Krystian Pietruszka <kpietru@lokolab.net>
# License MIT

require 'lokolab/rbfcgi/server'

module LokoLab
  module Rbfcgi
    class Wrapper

      # Adds a custom path to the directory with packages.
      def add_custom_path_to_gems(custom_path_to_gems, sufix = '/lib')
        if !custom_path_to_gems.kind_of?(String)
          raise ArgumentError, 'custom_path_to_gems: invalid type. Must be a str.'
        end
        if !sufix.kind_of?(String)
          raise ArgumentError, 'sufix: invalid type. Must be a str.'
        end
        Dir[custom_path_to_gems + '/*' + sufix].each do |path|
          $LOAD_PATH.unshift(path)
        end
        return self
      end

      # Runs the server.
      def run
        # !important Global message for LokoLab::Rbfcgi::Server()
        ENV['lokolab.rbfcgi.wrapper'] = 'on'

        server = LokoLab::Rbfcgi::Server.new()
        server.run_for_wrapper()
      end
    end
  end
end

