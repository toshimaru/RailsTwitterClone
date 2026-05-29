# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'will_paginate-bootstrap-style/version'

Gem::Specification.new do |s|
  s.name        = 'will_paginate-bootstrap-style'
  s.version     = Bootstrap::WillPaginate::VERSION
  s.authors     = ['Ivan Palamarchuk']
  s.email       = 'i.delef@gmail.com'
  s.summary     = %q{Format will_paginate html to match Twitter Bootstrap styling.}
  s.description = %q{Hooks into will_paginate to format the html to match Twitter Bootstrap styling.}
  s.homepage    = 'https://github.com/delef/will_paginate-bootstrap-style'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.9.2'
  s.rubyforge_project     = 'will_paginate-bootstrap-style'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'will_paginate', '~> 4.0', '>= 4.0.0'
end
