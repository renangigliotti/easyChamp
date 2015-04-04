class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :championship_id
      t.string :name
      t.string :logo
      t.string :abbreviation

      t.timestamps
    end
  end
end
