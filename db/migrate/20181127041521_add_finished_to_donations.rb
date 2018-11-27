class AddFinishedToDonations < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :finished, :boolean, default: false
  end
end
