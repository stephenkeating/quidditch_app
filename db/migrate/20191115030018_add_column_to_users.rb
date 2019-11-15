class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :answer_one, :string
    add_column :users, :answer_two, :string
    add_column :users, :answer_three, :string
    add_column :users, :answer_four, :string
    add_column :users, :answer_five, :string
  end
end
