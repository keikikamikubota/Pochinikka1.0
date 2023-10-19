class ChangeColumnsAddNotnullOnAdmins < ActiveRecord::Migration[7.0]
  def change
    change_column :admins, :name, :string, null: false
    change_column :admins, :email, :string, null: false
    change_column :admins, :password_digest, :string, null: false
  end
end
