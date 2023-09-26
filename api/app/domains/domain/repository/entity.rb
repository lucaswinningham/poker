module Domain
  module Repository
    module Entity
      extend ActiveSupport::Concern

      def initialize_fields(**kwargs)
        kwargs.each do |field, value|
          public_send("#{field}=", value)
        end
      end

      class_methods do
        def fields(*new_fields)
          symbolized_fields = new_fields.map(&:to_sym)
          @all_fields = [*all_fields, *symbolized_fields]

          attr_accessor *symbolized_fields
        end

        private

        def all_fields
          @all_fields ||= []
        end
      end
    end
  end
end
