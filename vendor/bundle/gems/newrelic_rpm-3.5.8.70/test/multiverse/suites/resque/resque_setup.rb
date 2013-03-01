require 'resque'
require 'newrelic_rpm'

redis_port = ENV["NEWRELIC_MULTIVERSE_REDIS_PORT"]
$redis = Redis.new(:port => redis_port)
Resque.redis = $redis

class JobForTesting
  @queue = :resque_test

  def self.perform(key, val, sleep_duration=0)
    sleep sleep_duration
    $redis.set(key, val)
  end
end
