class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
