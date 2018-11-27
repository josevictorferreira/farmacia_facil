class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.boolean :is_accepted
      t.boolean :is_cancelled
      t.integer :points
      t.references :user, foreign_key: true
      t.references :donation, foreign_key: true

      t.timestamps
    end
  end
end
