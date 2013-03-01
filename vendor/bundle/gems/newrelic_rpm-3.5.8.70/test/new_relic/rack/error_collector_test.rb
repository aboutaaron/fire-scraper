require File.expand_path(File.join(File.dirname(__FILE__),'..', '..',
                                   'test_helper'))
require 'rack/test'
require 'new_relic/rack/error_collector'

module NewRelic::Rack
  class ErrorCollectorTest < Test::Unit::TestCase
    include Rack::Test::Methods

    class TestApp
      def call(env)
        if env['PATH_INFO'] == '/ignored'
          env['action_dispatch.request.parameters'] = {
            'controller' => 'test_ignore',
            'action'     => 'ignored'
          }
        end
        raise 'unhandled error'
      end
    end

    def app
      NewRelic::Rack::ErrorCollector.new(TestApp.new)
    end

    def setup
      NewRelic::Agent.reset_config
      NewRelic::Agent.manual_start
      NewRelic::Agent.instance.error_collector
      NewRelic::Agent.instance.error_collector.errors = []

      # sanity checks
      assert NewRelic::Agent.instance.error_collector.enabled?
      NewRelic::Agent.instance.error_collector \
        .instance_variable_set(:@ignore_filter, nil)
      assert !NewRelic::Agent.instance.error_collector.ignore_error_filter
    end

    def test_notice_and_reraise_errors
      assert_raise RuntimeError do
        get '/'
      end

      assert_equal('unhandled error',
                   NewRelic::Agent.instance.error_collector.errors[0].message)
    end

    def test_ignore_filtered_errors
      NewRelic::Agent.instance.error_collector.ignore_error_filter do |error|
        !error.kind_of?(RuntimeError)
      end

      assert_raise RuntimeError do
        get '/'
      end

      assert(NewRelic::Agent.instance.error_collector.errors.empty?,
             'noticed an error that should have been ignored')
    end

    def test_ignore_errors_from_ignored_actions
      assert_raise RuntimeError do
        get '/ignored'
      end

      assert(NewRelic::Agent.instance.error_collector.errors.empty?,
             'noticed an error that should have been ignored')
    end

    def test_handles_parameter_parsing_exceptions
      bad_request = stub(:env => {}, :path => '/', :referer => '')
      bad_request.stubs(:params).raises(TypeError, "can't convert nil into Hash")
      Rack::Request.stubs(:new).returns(bad_request)

      assert_raise RuntimeError do
        get '/'
      end

      assert_equal('unhandled error',
                   NewRelic::Agent.instance.error_collector.errors[0].message)
      assert_match(/failed to capture request parameters/i,
                   NewRelic::Agent.instance.error_collector.errors[0].params[:request_params]['error'])
    end

  end
end

class TestIgnoreController
  @do_not_trace = { :only => :ignored }
end
