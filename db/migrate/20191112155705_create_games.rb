class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :user_house_id
      t.integer :computer_house_id

      t.timestamps
    end
  end
end
