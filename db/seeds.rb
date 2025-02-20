MedicationDosage.destroy_all
Medication.destroy_all
Dosage.destroy_all

medications = {}
[ "Metformin", "Phentermine", "Naltrexone", "Wellbutrin", "Topiramate", "Ozempic", "Bupropion" ].each do |name|
  medications[name] = Medication.create!(name: name)
end

dosages = {}
[
  [ "500 mg", "Once daily", 30 ],
  [ "500 mg", "Twice daily", 30 ],
  [ "1000 mg", "Once daily", 30 ],
  [ "15 mg", "Once daily", 14 ],
  [ "30 mg", "Once daily", 14 ],
  [ "37.5 mg", "Once daily", 14 ],
  [ "25 mg", "Once daily", 7 ],
  [ "50 mg", "Once daily", 28 ],
  [ "50 mg", "Twice daily", 28 ],
  [ "100 mg", "Twice daily", 14 ],
  [ "150 mg", "Once daily", 14 ],
  [ "150 mg", "Twice daily", 14 ],
  [ "25 mg", "Once daily", 30 ],
  [ "25 mg", "Twice daily", 30 ],
  [ "50 mg", "Twice daily", 30 ],
  [ "0.25 mg", "Once weekly", 4 ],
  [ "0.5 mg", "Once weekly", 4 ],
  [ "1 mg", "Once weekly", 4 ],
  [ "75 mg", "Once daily", 21 ],
  [ "150 mg", "Once daily", 21 ],
  [ "150 mg", "Twice daily", 21 ]
].each do |amount, frequency, duration|
  dosages["#{amount} #{frequency} #{duration}"] = Dosage.create!(
    amount: amount,
    frequency: frequency,
    default_duration: duration
  )
end

medication_dosages = [
  [ "Metformin", "500 mg Once daily 30", 5.00 ],
  [ "Metformin", "500 mg Twice daily 30", 5.00 ],
  [ "Metformin", "1000 mg Once daily 30", 5.00 ],
  [ "Phentermine", "15 mg Once daily 14", 15.00 ],
  [ "Phentermine", "30 mg Once daily 14", 15.00 ],
  [ "Phentermine", "37.5 mg Once daily 14", 15.00 ],
  [ "Naltrexone", "25 mg Once daily 7", 12.00 ],
  [ "Naltrexone", "50 mg Once daily 28", 12.00 ],
  [ "Naltrexone", "50 mg Twice daily 28", 12.00 ],
  [ "Wellbutrin", "100 mg Twice daily 14", 10.00 ],
  [ "Wellbutrin", "150 mg Once daily 14", 10.00 ],
  [ "Wellbutrin", "150 mg Twice daily 14", 10.00 ],
  [ "Topiramate", "25 mg Once daily 30", 8.00 ],
  [ "Topiramate", "25 mg Twice daily 30", 8.00 ],
  [ "Topiramate", "50 mg Twice daily 30", 8.00 ],
  [ "Ozempic", "0.25 mg Once weekly 4", 40.00 ],
  [ "Ozempic", "0.5 mg Once weekly 4", 40.00 ],
  [ "Ozempic", "1 mg Once weekly 4", 40.00 ],
  [ "Bupropion", "75 mg Once daily 21", 2.50 ],
  [ "Bupropion", "150 mg Once daily 21", 3.00 ],
  [ "Bupropion", "150 mg Twice daily 21", 3.50 ]
]

medication_dosages.each do |medication_name, dosage_key, price|
  MedicationDosage.create!(
    medication_id: medications[medication_name].id,
    dosage_id: dosages[dosage_key].id,
    unit_price: price
  )
end

puts "✅ Database seeded successfully!"
