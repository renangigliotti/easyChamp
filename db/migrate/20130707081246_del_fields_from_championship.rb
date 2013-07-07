class DelFieldsFromChampionship < ActiveRecord::Migration
  def change
  	remove_column  :championships, :groups
  	remove_column  :championships, :classification
  end
end
