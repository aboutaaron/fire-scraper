require 'socket'

class ServiceTimeoutTest < Test::Unit::TestCase

  PORT = 10_000 + ($$ % 10_000)

  def setup
    hk = TCPServer.new('127.0.0.1',PORT)

    Thread.new {
      client = hk.accept
      what = client.gets
      sleep 4
      client.close
      Thread.exit
    }
  end

  def test_service_timeout
    server = NewRelic::Control::Server.new('localhost',PORT,'127.0.0.1')
    NewRelic::Agent.config.apply_config(:timeout => 0.1)

    service = NewRelic::Agent::NewRelicService.new('deadbeef', server)	

    assert_raise Timeout::Error do
      service.send('send_request',
                   :uri => '/agent_listener/8/bd0e1d52adade840f7ca727d29a86249e89a6f1c/get_redirect_host',
                   :encoding => 'UTF-8', :collector => server, :data => 'blah')
    end
  end

end
