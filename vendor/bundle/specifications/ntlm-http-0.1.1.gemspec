# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ntlm-http"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kohei Kajimoto,Kingsley Hendrickse"]
  s.autorequire = "net/ntlm_http"
  s.date = "2009-05-19"
  s.description = "Ruby/NTLM HTTP provides NTLM authentication over http."
  s.email = "kingsley@mindflowsolutions.com"
  s.extra_rdoc_files = ["README"]
  s.files = ["README"]
  s.homepage = "http://www.mindflowsolutions.net"
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = "rubyntlm"
  s.rubygems_version = "2.0.0"
  s.summary = "Ruby/NTLM HTTP library."
end
