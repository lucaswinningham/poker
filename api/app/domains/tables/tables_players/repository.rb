module TablesPlayers
  module Repository
    include Domain::Repository

    entity TablesPlayers::Repository::Entity
    model TablesPlayers::Repository::Model

    class << self
      def players_for_table(table)
        player_ids = model_class.where(table_id: table.id).pluck(:player_id)
        Players::Repository.fetch_all(player_ids)
      end

      def make(table:, player:)
        to_entity model_class.create(table_id: table.id, player_id: player.id)
      end
    end
  end
end
