class AddExpiresAtToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :expire_at, :datetime
  end
end
