# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jquery-tablesorter"
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jun Lin"]
  s.date = "2013-02-06"
  s.description = "Simple integration of jquery-tablesorter into the asset pipeline."
  s.email = ["linjunpop@gmail.com"]
  s.homepage = "https://github.com/linjunpop/jquery-tablesorter-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Simple integration of jquery-tablesorter into the asset pipeline."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["~> 3.1"])
    else
      s.add_dependency(%q<railties>, ["~> 3.1"])
    end
  else
    s.add_dependency(%q<railties>, ["~> 3.1"])
  end
end
