class AddDateToChampionship < ActiveRecord::Migration
  def change
  	add_column :championships, :date_start, :date
  end
end