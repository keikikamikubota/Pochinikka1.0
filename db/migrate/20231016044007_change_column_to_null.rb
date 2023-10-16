class ChangeColumnToNull < ActiveRecord::Migration[7.0]
  def up
    change_column :sheets, :code,:string, null: true
  end

  def down
    change_column :sheets, :code,:string, null: false
  end
end
