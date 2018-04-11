class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string     :token
      t.string     :description
      t.string     :path
      t.string     :query
      t.string     :selection
      t.text       :raw_result
      t.references :source
      t.integer    :agemax, default: 3600*8
      t.string     :status

      t.timestamps

      t.index :token
    end
  end
end
