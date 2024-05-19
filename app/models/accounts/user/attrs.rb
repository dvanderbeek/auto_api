module Accounts
  class User
    class Attrs
      def self.valid
        {
          id: 1,
          created_at: Time.current,
          updated_at: Time.current,
          name: 'Jonh Doe',
          email: 'jdoe@example.com'
        }
      end
    end
  end
end
