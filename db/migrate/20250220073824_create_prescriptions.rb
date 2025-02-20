class CreatePrescriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :prescriptions do |t|
      t.string :patient_name
      t.decimal :budget

      t.timestamps
    end
  end
end
