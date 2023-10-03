class CreateSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :sheets do |t|
      t.string :title, null: false
      t.integer :code, null: false

      t.timestamps
    end
  end
end
