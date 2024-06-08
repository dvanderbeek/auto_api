module ActiveModel
  module Type
    class String
      def example
        "example_value"
      end
    end

    class Integer
      def example
        100
      end
    end

    class Text
      def example
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      end
    end

    class DateTime
      def example
        '2024-06-08T14:33:47Z'
      end
    end
  end
end
