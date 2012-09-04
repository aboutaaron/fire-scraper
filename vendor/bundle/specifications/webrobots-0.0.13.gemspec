# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "webrobots"
  s.version = "0.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Akinori MUSHA"]
  s.date = "2012-01-24"
  s.description = "This library helps write robots.txt compliant web robots in Ruby.\n"
  s.email = "knu@idaemons.org"
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]
  s.files = ["LICENSE.txt", "README.rdoc"]
  s.homepage = "https://github.com/knu/webrobots"
  s.licenses = ["2-clause BSDL"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A Ruby library to help write robots.txt compliant web robots"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<racc>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.11"])
      s.add_development_dependency(%q<nokogiri>, [">= 1.4.4"])
    else
      s.add_dependency(%q<racc>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, ["~> 0.9.11"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
    end
  else
    s.add_dependency(%q<racc>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, ["~> 0.9.11"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
  end
end
