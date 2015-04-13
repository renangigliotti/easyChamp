class CreateChampionshipsUsers < ActiveRecord::Migration
  def change
    create_table(:championships_users) do |t|
      t.belongs_to :championship, index: true
      t.belongs_to :user, index: true
    end  	
  end
end