class AddSpreadsheetIdAndRangeToSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :sheets, :spreadsheet_id, :string
    add_column :sheets, :range, :string
  end
end
