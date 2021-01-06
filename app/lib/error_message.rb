# frozen_string_literal: true

class ErrorMessage
  module User
    class << self
      def not_exist
        "user not exist"
      end

      def id_not_exist
        "user id not exit"
      end
    end
  end

  module Friend
    class << self
      def not_friends
        "not friends"
      end

      def invalid
        "invalid friend"
      end
    end
  end

  module Sleep
    class << self
      def invalid_from
        "sleep from should be earlier than to"
      end
    end
  end
end