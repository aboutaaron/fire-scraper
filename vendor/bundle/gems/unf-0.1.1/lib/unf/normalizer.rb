if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'
  require 'unf/normalizer_jruby'
else
  require 'unf/normalizer_cruby'
end

# UTF-8 string normalizer class.  Implementations may vary depending
# on the platform.
class UNF::Normalizer
  class << self
    # :singleton-method: new
    # :call-seq:
    #   new
    #   instance
    #
    # Returns a normalizer instance.

    # :stopdoc:
    def instance
      @@normalizer ||= new
    end
    # :startdoc:

    # A shortcut for new.normalize(string, form).
    def normalize(string, form)
      instance.normalize(string, form)
    end
  end

  # :method: normalize
  # :call-seq:
  #   normalize(string, form)
  #
  # Normalizes a UTF-8 string into a given form (:nfc, :nfd, :nfkc or
  # :nfkd).
end
