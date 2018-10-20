class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.belongs_to :user, index: true
      t.integer :balance

      t.timestamps
    end
  end
end
