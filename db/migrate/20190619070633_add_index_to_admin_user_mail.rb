class AddIndexToAdminUserMail < ActiveRecord::Migration[5.2]
  def change
    add_index :admin_users, :mail, unique: true
  end
end
