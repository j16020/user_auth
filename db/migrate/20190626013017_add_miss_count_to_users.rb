class AddMissCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :MissCount, :integer, default: 3
  end
end
