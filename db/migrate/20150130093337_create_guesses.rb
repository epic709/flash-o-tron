class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :round
      t.integer :card_id
      t.integer :correct
      t.integer :incorrect
      t.timestamps null: false
    end
  end
end