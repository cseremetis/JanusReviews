class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
        t.string :productName
        t.integer :face1
        t.integer :face2
        t.integer :face3
        t.integer :face4
        t.integer :face5
        t.integer :face6
    end
  end

  def down
    drop_table :products
  end
end
