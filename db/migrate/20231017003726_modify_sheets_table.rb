class ModifySheetsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :sheets, :code, :string

    change_column_null :sheets, :spreadsheet_id, false

    change_column_null :sheets, :range, false
  end
end
