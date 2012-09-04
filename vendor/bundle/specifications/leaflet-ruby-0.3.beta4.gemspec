# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "leaflet-ruby"
  s.version = "0.3.beta4"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charlie Savage"]
  s.date = "2012-02-03"
  s.homepage = "https://github.com/cfis/leaflet-ruby"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "1.8.24"
  s.summary = "Wraps the Leaflet Javascript Mapping Library in a Rails asset gem.  For more information about Leaflet please see http://leaflet.cloudmade.com."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
