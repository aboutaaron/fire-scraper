module NewRelic
  # We really don't want to send bad values to the collector, and it doesn't
  # accept types like Rational that have occasionally slipped into our data.
  #
  # These methods are intended to safely coerce things into the form we want,
  # to provide documentation of expected types on to_collector_array methods,
  # and to log failures if totally invalid data gets into outgoing data
  module Coerce
    def int(value, context=nil)
      Integer(value)
    rescue => error
      log_failure(value, Integer, context, error)
      0
    end

    def float(value, context=nil)
      Float(value)
    rescue => error
      log_failure(value, Float, context, error)
      0.0
    end

    def string(value, context=nil)
      return value if value.nil?
      String(value)
    rescue => error
      log_failure(value.class, String, context, error)
      ""
    end

    def log_failure(value, type, context, error)
      msg = "Unable to convert '#{value}' to #{type}"
      msg += " in context '#{context}'" if context
      NewRelic::Agent.logger.warn(msg, error)
    end
  end
end
