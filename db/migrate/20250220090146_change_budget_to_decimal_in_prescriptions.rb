class ChangeBudgetToDecimalInPrescriptions < ActiveRecord::Migration[8.0]
  def change
    change_column :prescriptions, :budget, :decimal, precision: 10, scale: 2
  end
end
