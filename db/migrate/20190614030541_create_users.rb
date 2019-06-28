class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :mail, :null => false
      t.string :uuid, :null => false
      t.string :mcid
      t.integer :flag

      t.timestamps
    end
  end
end
