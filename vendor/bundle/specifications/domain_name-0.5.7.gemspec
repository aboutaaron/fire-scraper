# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "domain_name"
  s.version = "0.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Akinori MUSHA"]
  s.date = "2013-01-07"
  s.description = "This is a Domain Name manipulation library for Ruby.\n\nIt can also be used for cookie domain validation based on the Public\nSuffix List.\n"
  s.email = ["knu@idaemons.org"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md"]
  s.homepage = "https://github.com/knu/ruby-domain_name"
  s.licenses = ["BSD + MPL 1.1/GPL 2.0/LGPL 2.1"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Domain Name manipulation library for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unf>, ["~> 0.0.3"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_development_dependency(%q<rdoc>, [">= 2.4.2"])
    else
      s.add_dependency(%q<unf>, ["~> 0.0.3"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_dependency(%q<rdoc>, [">= 2.4.2"])
    end
  else
    s.add_dependency(%q<unf>, ["~> 0.0.3"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.2.0"])
    s.add_dependency(%q<rdoc>, [">= 2.4.2"])
  end
end
