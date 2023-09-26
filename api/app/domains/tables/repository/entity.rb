module Tables
  module Repository
    class Entity
      include Domain::Repository::Entity

      fields :id

      def initialize(**kwargs)
        initialize_fields(**kwargs)
      end

      def players
        TablesPlayers::Repository.players_for_table(self)
      end

      def add_player(player)
        TablesPlayers::Repository.make(table: self, player: player)
      end
    end
  end
end
