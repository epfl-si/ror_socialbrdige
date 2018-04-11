class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.string :type
      t.string :uid
      t.text :data
      t.references :user
      t.integer :check_interval, default: 2592000
      t.datetime :next_check
      t.timestamps
    end
  end
end
