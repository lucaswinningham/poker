module Tables
  module Repository
    include Domain::Repository

    entity Tables::Repository::Entity
    model Tables::Repository::Model

    class << self
      def fetch(id)
        to_entity model_class.find_by(id: id)
      end
    end
  end
end
