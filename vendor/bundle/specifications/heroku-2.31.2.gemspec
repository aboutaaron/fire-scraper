# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "heroku"
  s.version = "2.31.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Heroku"]
  s.date = "2012-09-02"
  s.description = "Client library and command-line tool to deploy and manage apps on Heroku."
  s.email = "support@heroku.com"
  s.executables = ["heroku"]
  s.files = ["bin/heroku"]
  s.homepage = "http://heroku.com/"
  s.licenses = ["MIT"]
  s.post_install_message = " !    Heroku recommends using the Heroku Toolbelt to install the CLI.\n !    Download it from: https://toolbelt.heroku.com\n"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Client library and CLI to deploy apps on Heroku."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<heroku-api>, ["~> 0.3.4"])
      s.add_runtime_dependency(%q<netrc>, ["~> 0.7.7"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_runtime_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
    else
      s.add_dependency(%q<heroku-api>, ["~> 0.3.4"])
      s.add_dependency(%q<netrc>, ["~> 0.7.7"])
      s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
      s.add_dependency(%q<launchy>, [">= 0.3.2"])
      s.add_dependency(%q<rubyzip>, [">= 0"])
    end
  else
    s.add_dependency(%q<heroku-api>, ["~> 0.3.4"])
    s.add_dependency(%q<netrc>, ["~> 0.7.7"])
    s.add_dependency(%q<rest-client>, ["~> 1.6.1"])
    s.add_dependency(%q<launchy>, [">= 0.3.2"])
    s.add_dependency(%q<rubyzip>, [">= 0"])
  end
end
