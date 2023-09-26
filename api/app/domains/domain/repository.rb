module Domain
  module Repository
    extend ActiveSupport::Concern

    class_methods do
      def entity(klass)
        @entity_class = klass
      end

      def model(klass)
        @model_class = klass

        private_constant klass.name.split('::').last.to_sym
      end

      private

      attr_reader :entity_class, :model_class

      def to_entity(record)
        entity_class.new(**record.attributes)
      end
    end
  end
end
