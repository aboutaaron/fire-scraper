# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "responders"
  s.version = "0.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jos\u{e9} Valim"]
  s.date = "2012-09-27"
  s.description = "A set of Rails 3 responders to dry up your application"
  s.email = "contact@plataformatec.com.br"
  s.homepage = "http://github.com/plataformatec/responders"
  s.require_paths = ["lib"]
  s.rubyforge_project = "responders"
  s.rubygems_version = "1.8.25"
  s.summary = "A set of Rails 3 responders to dry up your application"

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
