# -*- encoding: utf-8 -*-
# stub: webpacker 5.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "webpacker".freeze
  s.version = "5.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/rails/webpacker/blob/v5.4.4/CHANGELOG.md", "source_code_uri" => "https://github.com/rails/webpacker/tree/v5.4.4" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze, "Gaurav Tiwari".freeze]
  s.date = "2023-01-31"
  s.email = ["david@basecamp.com".freeze, "gaurav@gauravtiwari.co.uk".freeze]
  s.homepage = "https://github.com/rails/webpacker".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Use webpack to manage app-like JavaScript modules in Rails".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.2"])
  s.add_runtime_dependency(%q<railties>.freeze, [">= 5.2"])
  s.add_runtime_dependency(%q<rack-proxy>.freeze, [">= 0.6.1"])
  s.add_runtime_dependency(%q<semantic_range>.freeze, [">= 2.3.0"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 1.3.0"])
  s.add_development_dependency(%q<rubocop>.freeze, ["= 0.93.1"])
  s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0"])
end
