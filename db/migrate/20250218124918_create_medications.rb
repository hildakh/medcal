class CreateMedications < ActiveRecord::Migration[8.0]
  def change
    create_table :medications do |t|
      t.string :name

      t.timestamps
    end
  end
end
