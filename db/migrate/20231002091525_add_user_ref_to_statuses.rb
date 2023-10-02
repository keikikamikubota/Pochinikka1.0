class AddUserRefToStatuses < ActiveRecord::Migration[7.0]
  def change
    add_reference :statuses, :user, null: false, foreign_key: true
  end
end
