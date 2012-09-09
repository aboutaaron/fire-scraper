# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gon"
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["gazay"]
  s.date = "2012-07-24"
  s.description = "If you need to send some data to your js files and you don't want to do this with long way trough views and parsing - use this force!"
  s.email = ["alex.gaziev@gmail.com"]
  s.homepage = "https://github.com/gazay/gon"
  s.require_paths = ["lib"]
  s.rubyforge_project = "gon"
  s.rubygems_version = "1.8.24"
  s.summary = "Get your Rails variables in your JS"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 2.3.0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rabl>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jbuilder>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 2.3.0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rabl>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jbuilder>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 2.3.0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rabl>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jbuilder>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
