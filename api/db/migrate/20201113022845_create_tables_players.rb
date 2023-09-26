class CreateTablesPlayers < ActiveRecord::Migration[6.0]
  def change
    name = :tables_players
    col_options = { type: :uuid }
    create_join_table(:tables, :players, table_name: name, column_options: col_options) do |t|
      t.index [:table_id, :player_id], unique: true
    end
  end
end
