module Players
  module Repository
    include Domain::Repository

    entity Players::Repository::Entity
    model Players::Repository::Model

    class << self
      # TODO: move to Domain::Repository, remove from Tables::Repository
      def fetch(id)
        to_entity model_class.find_by(id: id)
      end

      def fetch_all(player_ids)
        model_class.where(id: player_ids).all.map(&:to_entity)
      end
    end
  end
end
