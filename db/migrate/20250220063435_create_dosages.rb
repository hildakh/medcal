class CreateDosages < ActiveRecord::Migration[8.0]
  def change
    create_table :dosages do |t|
      t.string :amount
      t.string :frequency
      t.integer :default_duration

      t.timestamps
    end
  end
end
