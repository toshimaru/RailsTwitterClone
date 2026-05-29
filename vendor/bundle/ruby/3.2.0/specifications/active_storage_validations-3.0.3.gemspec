# -*- encoding: utf-8 -*-
# stub: active_storage_validations 3.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "active_storage_validations".freeze
  s.version = "3.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/igorkasyanchuk/active_storage_validations/issues", "changelog_uri" => "https://github.com/igorkasyanchuk/active_storage_validations/blob/master/CHANGES.md", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/igorkasyanchuk/active_storage_validations" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Kasyanchuk".freeze]
  s.date = "2025-12-13"
  s.description = "Validations for Active Storage (presence)".freeze
  s.email = ["igorkasyanchuk@gmail.com".freeze]
  s.homepage = "https://github.com/igorkasyanchuk/active_storage_validations".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Validations for Active Storage".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activejob>.freeze, [">= 6.1.4"])
  s.add_runtime_dependency(%q<activemodel>.freeze, [">= 6.1.4"])
  s.add_runtime_dependency(%q<activestorage>.freeze, [">= 6.1.4"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 6.1.4"])
  s.add_runtime_dependency(%q<marcel>.freeze, [">= 1.0.3"])
  s.add_development_dependency(%q<combustion>.freeze, ["~> 1.3"])
  s.add_development_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
  s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.4"])
  s.add_development_dependency(%q<minitest-mock_expectations>.freeze, ["~> 1.2", ">= 1.2.0"])
  s.add_development_dependency(%q<minitest-stub_any_instance>.freeze, ["~> 1.0", ">= 1.0.3"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  s.add_development_dependency(%q<ruby-vips>.freeze, [">= 2.1.0"])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  s.add_development_dependency(%q<webmock>.freeze, [">= 3"])
end
