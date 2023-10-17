class UpdateForeignKeyForImportDetails < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :import_details, :sheets

    add_foreign_key :import_details, :sheets, on_delete: :cascade
  end
end
