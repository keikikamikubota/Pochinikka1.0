class CreateImportDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :import_details do |t|
      t.integer :sheet_column_number
      t.integer :selected_title
      t.references :sheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
