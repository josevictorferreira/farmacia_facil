class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.string :description
      t.integer :quantity
      t.date :shelf_life
      t.boolean :has_packing
      t.belongs_to :user
      t.belongs_to :medicine

      t.timestamps
    end
  end
end
