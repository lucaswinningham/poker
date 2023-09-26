module Players
  module Repository
    class Entity
      include Domain::Repository::Entity

      fields :id, :name

      def initialize(**kwargs)
        initialize_fields(**kwargs)
      end
    end
  end
end
