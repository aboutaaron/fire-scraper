# RUBY-839 make sure there is no STDOUT chatter
require 'open3'

class StartUpTest < Test::Unit::TestCase
  def test_should_not_print_to_stdout_when_logging_available
    ruby = 'require "newrelic_rpm"; NewRelic::Agent.manual_start; NewRelic::Agent.shutdown'
    cmd = "bundle exec ruby -e '#{ruby}'"

    sin, sout, serr = Open3.popen3(cmd)
    output = sout.read + serr.read

    jruby_noise = [
      "JRuby limited openssl loaded. http://jruby.org/openssl\n",
      "gem install jruby-openssl for full support.\n",
      /Exception\: java\.lang.*\n/]

    jruby_noise.each {|noise| output.gsub!(noise, "")}

    assert_equal '', output.chomp
  end
end
