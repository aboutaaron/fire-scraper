require 'new_relic/agent/event_listener'

module NewRelic::Rack
  class AgentHooks
    def initialize(app, options = {})
      @app = app
    end

    # method required by Rack interface
    # [status, headers, response]
    def call(env)
      events = NewRelic::Agent.instance.events
      events.notify(:before_call, env)
      result = @app.call(env)
      events.notify(:after_call, env, result)
      result
    end
  end
end

