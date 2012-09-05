# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "font-awesome-sass-rails"
  s.version = "2.0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hsiao-Ting Yu"]
  s.date = "2012-06-05"
  s.description = "Font Awesome, SASS version, with assets pipeline, for Rails 3.1+"
  s.email = ["sst.dreams@gmail.com"]
  s.homepage = "https://github.com/littlebtc/font-awesome-sass-rails"
  s.require_paths = ["lib"]
  s.rubyforge_project = "font-awesome-sass-rails"
  s.rubygems_version = "1.8.24"
  s.summary = "Font Awesome in SASS for Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1.1"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 3.1.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1.1"])
      s.add_dependency(%q<sass-rails>, [">= 3.1.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1.1"])
    s.add_dependency(%q<sass-rails>, [">= 3.1.1"])
  end
end
