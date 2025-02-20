class CreatePrescriptionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :prescription_items do |t|
      t.references :prescription, null: false, foreign_key: true
      t.references :medication_dosage, null: false, foreign_key: true
      t.integer :custom_duration

      t.timestamps
    end
  end
end
