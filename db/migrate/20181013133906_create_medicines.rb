class CreateMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :targe
      t.string :leaflet
      t.boolean :doctor_prescription

      t.timestamps
    end
  end
end
