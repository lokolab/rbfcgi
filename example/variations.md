Variations for runing application via Rbfcgi
============================================

- Testing environment:
  - Ruby (2.3.0),
    Apache (2.4.7), Ubuntu (14.04)

Rbfcgi – wrapper for applications in Ruby via "mod_fcgid".
____________________________________________________________

Wrapper
-------

Create a file named "ruby2.fcgi" outside your home directory.

Basic wrapper*:

    #!/usr/local/ruby/2.3.0/bin/ruby

    require 'lokolab/rbfcgi/wrapper'

    w = LokoLab::Rbfcgi::Wrapper.new()
    w.run()

Application
-----------

Create a file named "app.rb" inside your website’s document root.

Basic application:

    puts "content-type: text/html\r\n\r\n"
    puts "Hello World!"

Or, advanced solution:

    begin
      Module.const_get('LokoLab::Rbfcgi::Server')
    rescue NameError => e
      require 'lokolab/rbfcgi/server'
    end

    class App
      def call(env)
        puts "content-type: text/html\r\n\r\n"
        puts "Hello World!"
      end
    end

    server = LokoLab::Rbfcgi::Server.new(App)
    server.run()

________________________________________________________
[*] Paths and username should be modified to the server.

