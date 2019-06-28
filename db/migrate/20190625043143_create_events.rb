class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :eventid
      t.string :uuid
      t.integer :flag

      t.timestamps
    end
  end
end
