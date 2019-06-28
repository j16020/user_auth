class AddRememberDigestToAdminUser < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :remember_digest, :string
  end
end
