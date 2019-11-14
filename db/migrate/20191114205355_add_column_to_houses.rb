class AddColumnToHouses < ActiveRecord::Migration[6.0]
  def change
    add_column :houses, :founder, :string
    add_column :houses, :animal, :string
    add_column :houses, :head_professor, :string
    add_column :houses, :ghost, :string
  end
end
