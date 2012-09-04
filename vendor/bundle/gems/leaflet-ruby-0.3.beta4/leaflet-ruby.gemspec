# encoding: utf-8
Gem::Specification.new do |spec|
  spec.name        = 'leaflet-ruby'
  spec.version     = '0.3.beta4'
  spec.homepage    = 'https://github.com/cfis/leaflet-ruby'
  spec.summary     = <<-EOS
Wraps the Leaflet Javascript Mapping Library in a Rails asset gem.  For more information
about Leaflet please see http://leaflet.cloudmade.com.
EOS
  spec.authors = ['Charlie Savage']
  spec.platform = Gem::Platform::RUBY
  spec.files = Dir.glob(['leaflet-ruby.gemspec',
                         'CHANGELOG.rdoc',
                         'LICENSE',
                         'Rakefile',
                         'README.rdoc',
                         'lib/leaflet-ruby.rb',
                         'lib/zerista/*',
                         'lib/leaflet/**/*',
                         'vendor/assets/images/*',
                         'vendor/assets/stylesheets/*',
                         'vendor/assets/javascripts/*'])
  spec.required_ruby_version = '>= 1.8.7'
  spec.date = Time.now
end