
require 'active_support/core_ext'
require File.dirname(__FILE__) + '/../lib/rails-timeago.rb'
require File.dirname(__FILE__) + '/support/stub.rb'

RSpec.configure do |config|
  config.mock_with :rspec
end
