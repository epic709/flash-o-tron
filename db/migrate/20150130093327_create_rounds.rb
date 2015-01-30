class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :user #every round belongs to one user
      t.belongs_to :deck #each deck is for a specific round
      t.timestamps null: false
    end
  end
end
