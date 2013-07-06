class AddDuelToGames < ActiveRecord::Migration
  def change
  	add_column :games, :duel1, :string
  	add_column :games, :duel2, :string
  	remove_column  :games, :duel
  end
end
