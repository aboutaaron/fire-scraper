# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "d3-rails"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Markus Fenske"]
  s.date = "2012-06-29"
  s.description = "This gem provides D3 for Rails 3.1 Asset Pipeline."
  s.email = ["iblue@gmx.net"]
  s.homepage = "https://github.com/iblue/d3-rails"
  s.require_paths = ["lib"]
  s.rubyforge_project = "d3-rails"
  s.rubygems_version = "2.0.0"
  s.summary = "D3 for Rails 3.1 Asset Pipeline"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_development_dependency(%q<rails>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<rails>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<rails>, [">= 3.1"])
  end
end
