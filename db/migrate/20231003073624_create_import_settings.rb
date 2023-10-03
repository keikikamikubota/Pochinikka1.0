class CreateImportSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :import_settings do |t|
      t.integer :sheet_column_number, null: false
      t.integer :selected_title, null: false

      t.timestamps
    end
  end
end
