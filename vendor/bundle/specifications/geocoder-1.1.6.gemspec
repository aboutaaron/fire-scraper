# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "geocoder"
  s.version = "1.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Reisner"]
  s.date = "2012-12-24"
  s.description = "Provides object geocoding (by street or IP address), reverse geocoding (coordinates to street address), distance queries for ActiveRecord and Mongoid, result caching, and more. Designed for Rails but works with Sinatra and other Rack frameworks too."
  s.email = ["alex@alexreisner.com"]
  s.executables = ["geocode"]
  s.files = ["bin/geocode"]
  s.homepage = "http://www.rubygeocoder.com"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Complete geocoding solution for Ruby."
end
