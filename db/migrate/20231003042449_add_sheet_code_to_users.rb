class AddSheetCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sheet_code, :integer
  end
end
