# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails-timeago"
  s.version = "1.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jan Graichen"]
  s.date = "2012-06-24"
  s.description = "jQuery Timeago helper for Rails 3"
  s.email = ["jan.graichen@altimos.de"]
  s.homepage = "https://github.com/jgraichen/rails-timeago"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A Rails Helper to create time tags usable for jQuery Timeago plugin"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.1"])
      s.add_dependency(%q<actionpack>, [">= 3.1"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.1"])
    s.add_dependency(%q<actionpack>, [">= 3.1"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
