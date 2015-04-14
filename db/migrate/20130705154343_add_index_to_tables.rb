class AddIndexToTables < ActiveRecord::Migration
  def change
     add_index(:championships, :id)
     add_index(:games, :id)
     add_index(:phases, :id)
     add_index(:rules, :id)
     add_index(:teams, :id)

     add_foreign_key(:championships, :rules)
     add_foreign_key(:teams, :championships)
     add_foreign_key(:games, :championships)
     add_foreign_key(:games, :phases)
     add_foreign_key(:games, :teams, column: :team1_id)
     add_foreign_key(:games, :teams, column: :team2_id)
  end
end
