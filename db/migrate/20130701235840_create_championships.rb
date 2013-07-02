class CreateChampionships < ActiveRecord::Migration
  def change
    create_table :championships do |t|
      t.string :name
      t.integer :rule_id
      t.integer :classification
      t.integer :groups

      t.timestamps
    end
  end
end
