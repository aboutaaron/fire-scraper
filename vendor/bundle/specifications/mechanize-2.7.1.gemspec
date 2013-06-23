# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mechanize"
  s.version = "2.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Hodel", "Aaron Patterson", "Mike Dalessio", "Akinori MUSHA", "Lee Jarvis"]
  s.date = "2013-05-27"
  s.description = "The Mechanize library is used for automating interaction with websites.\nMechanize automatically stores and sends cookies, follows redirects,\nand can follow links and submit forms.  Form fields can be populated and\nsubmitted.  Mechanize also keeps track of the sites that you have visited as\na history."
  s.email = ["drbrain@segment7.net", "aaronp@rubyforge.org", "mike.dalessio@gmail.com", "knu@idaemons.org", "ljjarvis@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "EXAMPLES.rdoc", "GUIDE.rdoc", "LICENSE.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "EXAMPLES.rdoc", "GUIDE.rdoc", "LICENSE.rdoc", "Manifest.txt", "README.rdoc"]
  s.homepage = "http://mechanize.rubyforge.org"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "mechanize"
  s.rubygems_version = "1.8.25"
  s.summary = "The Mechanize library is used for automating interaction with websites"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-http-digest_auth>, [">= 1.1.1", "~> 1.1"])
      s.add_runtime_dependency(%q<net-http-persistent>, [">= 2.5.2", "~> 2.5"])
      s.add_runtime_dependency(%q<mime-types>, [">= 1.17.2", "~> 1.17"])
      s.add_runtime_dependency(%q<http-cookie>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4"])
      s.add_runtime_dependency(%q<ntlm-http>, [">= 0.1.1", "~> 0.1"])
      s.add_runtime_dependency(%q<webrobots>, ["< 0.2", ">= 0.0.9"])
      s.add_runtime_dependency(%q<domain_name>, [">= 0.5.1", "~> 0.5"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.6"])
    else
      s.add_dependency(%q<net-http-digest_auth>, [">= 1.1.1", "~> 1.1"])
      s.add_dependency(%q<net-http-persistent>, [">= 2.5.2", "~> 2.5"])
      s.add_dependency(%q<mime-types>, [">= 1.17.2", "~> 1.17"])
      s.add_dependency(%q<http-cookie>, ["~> 1.0.0"])
      s.add_dependency(%q<nokogiri>, ["~> 1.4"])
      s.add_dependency(%q<ntlm-http>, [">= 0.1.1", "~> 0.1"])
      s.add_dependency(%q<webrobots>, ["< 0.2", ">= 0.0.9"])
      s.add_dependency(%q<domain_name>, [">= 0.5.1", "~> 0.5"])
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.6"])
    end
  else
    s.add_dependency(%q<net-http-digest_auth>, [">= 1.1.1", "~> 1.1"])
    s.add_dependency(%q<net-http-persistent>, [">= 2.5.2", "~> 2.5"])
    s.add_dependency(%q<mime-types>, [">= 1.17.2", "~> 1.17"])
    s.add_dependency(%q<http-cookie>, ["~> 1.0.0"])
    s.add_dependency(%q<nokogiri>, ["~> 1.4"])
    s.add_dependency(%q<ntlm-http>, [">= 0.1.1", "~> 0.1"])
    s.add_dependency(%q<webrobots>, ["< 0.2", ">= 0.0.9"])
    s.add_dependency(%q<domain_name>, [">= 0.5.1", "~> 0.5"])
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.6"])
  end
end
