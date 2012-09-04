# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails-timeago/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jan Graichen"]
  gem.email         = ["jan.graichen@altimos.de"]
  gem.description   = %q{jQuery Timeago helper for Rails 3}
  gem.summary       = %q{A Rails Helper to create time tags usable for jQuery Timeago plugin}
  gem.homepage      = "https://github.com/jgraichen/rails-timeago"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rails-timeago"
  gem.require_paths = ["lib"]
  gem.version       = Rails::Timeago::VERSION

  gem.add_dependency "activesupport", ">= 3.1"
  gem.add_dependency "actionpack", ">= 3.1"
  gem.add_development_dependency "rspec"
end
