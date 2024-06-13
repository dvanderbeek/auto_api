# require 'active_model/attribute_set'

module RestfulActions
  extend ActiveSupport::Concern

  included do
    class_attribute :available_restful_actions, default: [:index, :show, :create, :update, :destroy]
  end

  def initialize(*) # :nodoc:
    @allowed_attributes = self.class._allowed_attributes.deep_dup
    super
  end

  class_methods do
    def restful_actions(*actions)
      self.available_restful_actions = actions
    end

    def allowed_attributes
      @allowed_attributes
    end

    def restrict(name)
      self.pending_attribute_modifications << PendingRestricted.new(name)

      reset_allowed_attributes
    end

    def allow(name, **options)
      reset_allowed_attributes

      self.pending_attribute_modifications << PendingAllowed.new(name, options[:on])

      reset_allowed_attributes
    end

    def _allowed_attributes
      @allowed_attributes ||= begin
        # TODO: instead of a plain Hash, wrap in an object so we could do things like Model.allowed_attributes(:create)
        # and return attributes where actions includes 'create'

        attrs_hash = attribute_names.excluding("id", "created_at", "updated_at").each_with_object({}) do |name, attrs|
          attrs[name] = AllowedAttribute.new(name:, actions: [:create, :update])
        end

        apply_pending_attribute_modifications(attrs_hash)

        attrs_hash
      end
    end

    private

    class AllowedAttribute
      attr_accessor :name, :actions

      def initialize(name:, actions:)
        @name = name
        @actions = Array(actions)
      end
    end

    PendingAllowed = Struct.new(:name, :actions) do
      def apply_to(attribute_set)
        attribute_set[name.to_s] = AllowedAttribute.new(name:, actions:)
      end
    end

    PendingRestricted = Struct.new(:name) do
      def apply_to(attribute_set)
        attribute_set.delete(name.to_s)
      end
    end

    def pending_attribute_modifications
      @pending_attribute_modifications ||= []
    end

    def apply_pending_attribute_modifications(attribute_set)
      if superclass.respond_to?(:apply_pending_attribute_modifications, true)
        superclass.send(:apply_pending_attribute_modifications, attribute_set)
      end

      pending_attribute_modifications.each do |modification|
        modification.apply_to(attribute_set)
      end
    end

    def reset_allowed_attributes
      reset_allowed_attributes!
      subclasses.each { |subclass| subclass.send(:reset_allowed_attributes) }
    end

    def reset_allowed_attributes!
      @allowed_attributes = nil
      # @attribute_types = nil
    end
  end
end

ActiveRecord::Base.include(RestfulActions)
