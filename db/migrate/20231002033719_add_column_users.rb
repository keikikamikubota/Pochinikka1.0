class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :option1, :string
    add_column :users, :option2, :string
    add_column :users, :option3, :string
    add_column :users, :option4, :string
    add_column :users, :option5, :string
    add_column :users, :option6, :string
    add_column :users, :option7, :string
    add_column :users, :option8, :string
    add_column :users, :option9, :string
    add_column :users, :option10, :string

  end
end
