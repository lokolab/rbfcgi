Gem::Specification.new do |s|
  s.name                  = 'lokolab-rbfcgi'
  s.version               = File.read('README.md').match(/- Version:\s*([^\s]+)/)[1]
  s.summary               = 'Wrapper for applications in Ruby via "mod_fcgid".'
  s.description           = File.read('README.md')
  s.authors               = ['Krystian Pietruszka']
  s.email                 = ['kpietru@lokolab.net', 'info@lokolab.net']
  s.homepage              = 'http://www.lokolab.net'
  s.licenses              = ['MIT']
  s.files                 = [
    'lib/lokolab/rbfcgi/wrapper.rb',
    'lib/lokolab/rbfcgi/server.rb',
    'lib/lokolab/rbfcgi/tests/wrapper_test.rb',
    'lib/lokolab/rbfcgi/tests/server_test.rb',
    'example/rails_via_rbfcgi.md',
    'example/variations.md',
    'README.md',
    'LICENSE'
  ]
  s.required_ruby_version = '>= 2.2.3'
  s.add_runtime_dependency('fcgi', '>= 0.9.2.1', '< 1')
  s.add_runtime_dependency('rack', '>= 1.6.4', '< 3')
  s.add_development_dependency('test-unit', '~> 0')
end

