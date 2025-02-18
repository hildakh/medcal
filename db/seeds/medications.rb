medications = [
  { name: 'Medication1' },
  { name: 'Medication2' }
]

medications.each do |med|
  Medication.create!(med)
end
