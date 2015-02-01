class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
        t.string :productName
        t.integer :face1, default: 0
        t.integer :face2, default: 0
        t.integer :face3, default: 0
        t.integer :face4, default: 0
        t.integer :face5, default: 0
        t.integer :face6, default: 0
    end
  end

  def down
    drop_table :products
  end
end
