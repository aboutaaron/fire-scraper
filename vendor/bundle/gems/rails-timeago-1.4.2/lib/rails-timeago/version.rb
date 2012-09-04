module Rails
  module Timeago
    module VERSION
      MAJOR = 1
      MINOR = 4
      PATCH = 2
      STAGE = nil

      def self.to_s
        [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
      end
    end
  end
end
