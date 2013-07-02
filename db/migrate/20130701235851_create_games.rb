class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :championship_id
      t.integer :team1_id
      t.integer :placar1
      t.integer :team2_id
      t.integer :placar2
      t.integer :phase_id
      t.string :groups
      t.string :stage
      t.string :duel

      t.timestamps
    end
  end
end
