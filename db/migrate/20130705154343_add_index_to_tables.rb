class AddIndexToTables < ActiveRecord::Migration
  def change
   
   add_index :championships, :id
   add_index :games, :id
   add_index :phases, :id
   add_index :rules, :id
   add_index :teams, :id

   execute <<-SQL
      ALTER TABLE championships
        ADD CONSTRAINT fk_championships_rules
        FOREIGN KEY (rule_id)
        REFERENCES rules(id)
    SQL

   execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT fk_games_championships
        FOREIGN KEY (championship_id)
        REFERENCES championships(id)
    SQL

   execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT fk_games_phases
        FOREIGN KEY (phase_id)
        REFERENCES phases(id)
    SQL

   execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT fk_games_team1
        FOREIGN KEY (team1_id)
        REFERENCES teams(id)
    SQL

   execute <<-SQL
      ALTER TABLE games
        ADD CONSTRAINT fk_games_team2
        FOREIGN KEY (team2_id)
        REFERENCES teams(id)
    SQL

  end
end
