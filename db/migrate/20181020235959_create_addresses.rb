class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :user
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :number
      t.string :zipcode

      t.timestamps
    end
  end
end
