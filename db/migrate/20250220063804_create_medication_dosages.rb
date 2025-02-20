class CreateMedicationDosages < ActiveRecord::Migration[8.0]
  def change
    create_table :medication_dosages do |t|
      t.references :medication, null: false, foreign_key: true
      t.references :dosage, null: false, foreign_key: true
      t.decimal :unit_price

      t.timestamps
    end
  end
end
