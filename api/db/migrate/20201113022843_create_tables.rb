class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables, id: :uuid do |t|
      t.timestamps
    end
  end
end
