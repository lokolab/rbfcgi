rbfcgi
======
**This is development (master) version.<br> For production version (relase) see
<https://github.com/lokolab/rbfcgi/tree/v0.0.1>**
- Version: 0.0.1
- Technologies:
  - Ruby
- Compatibility:
  - Apache HTTP Server (>= 2.4)
  - mod_fcgid (>= 2.3)
  - Ruby (>= 2.2.3)
- Dependencies:
  - fcgi (>= 0.9.2.1, < 1)
  - rack (>= 1.6.4, < 3)
- Copyright / Authors:
  - Krystian Pietruszka <kpietru@lokolab.net>
- Licenses:
  - MIT <http://opensource.org/licenses/MIT>
- Download: <https://github.com/lokolab/rbfcgi/releases>
- Homepage: <http://www.lokolab.net>

Wrapper for applications in Ruby via "mod_fcgid".
_________________________________________________

Installing and configuring
--------------------------

First, install the "lokolab-rbfcgi" Ruby gem*:

    cd /tmp
    wget https://github.com/lokolab/rbfcgi/archive/master.tar.gz -O rbfcgi-master.tar.gz
    tar -xzvf rbfcgi-master.tar.gz
    cd rbfcgi-master
    gem build rbfcgi.gemspec
    # if relase without "...pre.dev..."
    gem install lokolab-rbfcgi-X.X.X.pre.dev.gem

Second, create a file named "app.rb" inside your
website’s document root and add the following lines:

    puts "content-type: text/html\r\n\r\n"
    puts "Hello World!"

Third, create a file named "ruby2.fcgi" outside
your home directory and add the following lines*:

    #!/usr/local/ruby/2.3.0/bin/ruby

    require 'lokolab/rbfcgi/wrapper'

    w = LokoLab::Rbfcgi::Wrapper.new()
    w.run()

Fourth, add the following lines to your Apache configuration*:

    <IfModule fcgid_module>
        Options +ExecCgi
        AddHandler fcgid-script .rb
        FcgidWrapper /path/to/wrapper/ruby2.fcgi .rb
        <IfModule suexec_module>
            SuexecUserGroup someuser someuser
        </IfModule>
    </IfModule>

Fifth, execute commands via shell*:

    chmod 744 /path/to/wrapper/ruby2.fcgi
    chown someuser:someuser /path/to/wrapper/ruby2.fcgi

Sixth, restart the Apache HTTP Server via shell:

    service apache2 restart

Finally, in the browser, enter `http://localhost/app.rb`

References
----------

1. [FastCGI Specification][1]
2. [Ruby on Rails via Lighttpd][2]
3. [Ruby cgi-wrapper][3]

[1]: http://web.archive.org/web/20160306081510/http://fastcgi.com/drupal/node/6?q=node/22
[2]: http://cholla.mmto.org/computers/web/rails/lighttpd_rails.html
[3]: http://svn.coderepos.org/share/lang/ruby/misc/cgi-wrapper/ruby-fcgi.rb

________________________________________________________
[*] Paths and username should be modified to the server.

