module Tables
  class Channel < ApplicationCable::Channel
    def subscribed
      player_id = '93a8c826-a2bf-4ad9-a6e0-4af959720736'
      stream_name = build_stream_name_for_player player_id
      stream_from stream_name
    end

    def join(data)
      # data_to_return = {
      #   **data,
      #   id: player_id
      # }

      # include player's name
      # player = Players::Repository.fetch(something)

      table.add_player player

      notify_all_players(action: 'joined', data: data)

      # ActionCable.server.broadcast(stream_name, action: 'joined', player: player)
    end

    # def check
    #   Tables.player_checks(player_id: player_id)
    # end

    private

    def table
      @table ||= Tables::Repository.fetch data['table_id']
    end

    def player
      @player ||= Players::Repository.fetch data['player_id']
    end

    def build_stream_name_for_player(player_id)
      "table_#{table.id}_player_#{player_id}"
    end

    def notify_all_players(**data)
      table.players.each do |player|
        stream_name = build_stream_name_for_player player.id
        ActionCable.server.broadcast(stream_name, **data)
      end
    end

    # def notify_subscription
    #   puts "\n\n\n\n\n\n\n\n\n"
    #   # ActionCable.server.broadcast('table_channel', table_key: 'table_string')
    # end
  end
end
