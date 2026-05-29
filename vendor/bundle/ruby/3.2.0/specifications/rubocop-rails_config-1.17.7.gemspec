# -*- encoding: utf-8 -*-
# stub: rubocop-rails_config 1.17.7 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop-rails_config".freeze
  s.version = "1.17.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Toshimaru".freeze, "Koichi ITO".freeze]
  s.date = "1980-01-02"
  s.description = "RuboCop configuration which has the same code style checking as official Ruby on Rails".freeze
  s.email = "me@toshimaru.net".freeze
  s.homepage = "https://github.com/toshimaru/rubocop-rails_config".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "RuboCop configuration which has the same code style checking as official Ruby on Rails".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<rubocop>.freeze, [">= 1.74.0"])
  s.add_runtime_dependency(%q<rubocop-ast>.freeze, [">= 1.38.0"])
  s.add_runtime_dependency(%q<rubocop-md>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<rubocop-minitest>.freeze, ["~> 0.37"])
  s.add_runtime_dependency(%q<rubocop-packaging>.freeze, ["~> 0.6"])
  s.add_runtime_dependency(%q<rubocop-performance>.freeze, ["~> 1.24"])
  s.add_runtime_dependency(%q<rubocop-rails>.freeze, ["~> 2.30"])
end
