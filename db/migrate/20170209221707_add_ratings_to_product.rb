class AddRatingsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :ratings, :integer, array: true, default: [0, 0, 0, 0, 0, 0]
  end
end
