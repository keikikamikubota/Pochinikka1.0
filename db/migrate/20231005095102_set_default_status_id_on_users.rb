class SetDefaultStatusIdOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :status_id, 1
  end
end
