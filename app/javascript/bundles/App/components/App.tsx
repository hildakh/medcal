import React, { useState } from 'react';
import { MedicationSelector } from './MedicationSelector/MedicationSelector';
import { SelectedMedication } from '../helpers/types';

function App() {
  const [selectedMedications, setSelectedMedications] = useState<SelectedMedication[]>([]);
  const [budget, setBudget] = useState(100);

  const handleAddMedication = (medication: SelectedMedication) => {
    setSelectedMedications([...selectedMedications, medication]);
  };

  return (
    <div className="min-h-screen bg-white">
      <div className="container mx-auto px-4 py-8">
        <header className="flex justify-between items-center mb-8">
          <div className="flex items-center space-x-3">
            <h1 className="text-2xl font-bold text-black">
              Prescription Cost Calculator
            </h1>
          </div>
        </header>

        <div className="grid grid-cols-12 gap-6">
          <div className="medicatio-selector col-span-12 md:col-span-6">
            <div className="bg-gray-50 p-4 rounded-lg shadow">
              <label className="block text-sm font-medium text-black">
                Budget ($)
              </label>
              <input
                type="number"
                value={budget}
                onChange={(e) => setBudget(Number(e.target.value))}
                className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
                min="0"
                step="0.01"
              />
            </div>
            <MedicationSelector onSelect={handleAddMedication} />
          </div>

          <div className='prescription-summary col-span-12 md:col-span-6'>
          <div className="bg-gray-50 p-4 rounded-lg shadow">
            <h3>
              Prescription Summary
            </h3>
            {
              selectedMedications.map((med: SelectedMedication) => (
                <>
                  <p>
                    {med.medication.name}
                  </p>
                  <p>{med.dosage.amount}</p>
                  <p>Added</p>
                </>
              ))
            }
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;