class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.integer :game_id
      t.integer :user_energy
      t.integer :computer_energy
      t.integer :user_score
      t.integer :computer_score
      t.integer :user_bludger_outcome
      t.integer :computer_bludger_outcome
      t.integer :user_snitch_chance
      t.integer :computer_snitch_chance
      t.integer :user_quaffle_allocation
      t.integer :user_bludger_allocation
      t.integer :user_snitch_allocation

      t.timestamps
    end
  end
end
