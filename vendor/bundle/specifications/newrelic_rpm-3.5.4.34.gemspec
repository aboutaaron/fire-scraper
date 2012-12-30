# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "newrelic_rpm"
  s.version = "3.5.4.34"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Clark", "Sam Goldstein", "Jon Guymon", "Ben Weintraub"]
  s.date = "2012-12-24"
  s.description = "New Relic is a performance management system, developed by New Relic,\nInc (http://www.newrelic.com).  New Relic provides you with deep\ninformation about the performance of your web application as it runs\nin production. The New Relic Ruby Agent is dual-purposed as a either a\nGem or plugin, hosted on\nhttp://github.com/newrelic/rpm/\n"
  s.email = "support@newrelic.com"
  s.executables = ["mongrel_rpm", "newrelic_cmd", "newrelic"]
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.md", "GUIDELINES_FOR_CONTRIBUTING.md", "newrelic.yml"]
  s.files = ["bin/mongrel_rpm", "bin/newrelic_cmd", "bin/newrelic", "CHANGELOG", "LICENSE", "README.md", "GUIDELINES_FOR_CONTRIBUTING.md", "newrelic.yml"]
  s.homepage = "http://www.github.com/newrelic/rpm"
  s.post_install_message = "PLEASE NOTE:\n\nDeveloper Mode is now a Rack middleware.\n\nDeveloper Mode is no longer available in Rails 2.1 and earlier.\nHowever, starting in version 2.12 you can use Developer Mode in any\nRack based framework, in addition to Rails.  To install developer mode\nin a non-Rails application, just add NewRelic::Rack::DeveloperMode to\nyour middleware stack.\n\nIf you are using JRuby, we recommend using at least version 1.4 or\nlater because of issues with the implementation of the timeout library.\n\nRefer to the README.md file for more information.\n\nPlease see http://github.com/newrelic/rpm/blob/master/CHANGELOG\nfor a complete description of the features and enhancements available\nin this version of the Ruby Agent.\n\n"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "New Relic Ruby Agent"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "New Relic Ruby Agent"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
