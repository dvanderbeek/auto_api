module Accounts
  class MfaReset
    class Attrs
      def self.valid
        {
          id: 1,
          created_at: Time.current,
          updated_at: Time.current,
          user_id: 1
        }
      end
    end
  end
end
