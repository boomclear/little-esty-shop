class AddStatusToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :status, :integer
  end
end
