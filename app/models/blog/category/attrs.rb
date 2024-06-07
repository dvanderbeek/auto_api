module Blog
  class Category
    class Attrs
      # TODO: Create example values for various attribute types and auto-generate these examples for the docs
      # For example, mark an attribute as an EthereumAddress (via a custom ActiveModel::Type), we could set it up to automatically
      # use Faker::Blockchain::Ethereum.address (and so forth). Then example values would be re-usable across resources
      def self.valid
        {
          id: 1,
          created_at: Time.current,
          updated_at: Time.current,
          name: 'My first catetory'
        }
      end
    end
  end
end
