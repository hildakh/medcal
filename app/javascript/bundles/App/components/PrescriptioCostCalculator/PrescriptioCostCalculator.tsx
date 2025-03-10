import React from 'react';
import { MedicationSelectorContainer } from '../MedicationSelectorContainer/MedicationSelectorContainer';
import PrescriptioSummary from '../PrescriptionSummary/PrescriptionSummary';
import { usePrescription } from '../../hooks/usePrescription';

const PrescriptioCostCalculator: React.FC = () => {
  const {
    budget,
    createPrescription,
    handleAddPrescriptionItem,
    prescriptionItems,
    setBudget,
    totalCost,
  } = usePrescription();

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
                onChange={(e) => setBudget(parseFloat(e.target.value))}
                className="mt-1 h-10 pl-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
                min="0"
                step="0.01"
              />
            </div>
            <MedicationSelectorContainer
              handleAddPrescriptionItem={handleAddPrescriptionItem}
            />
          </div>

          <PrescriptioSummary
            budget={budget}
            items={prescriptionItems}
            onSubmit={createPrescription}
            totalCost={totalCost}
          />
        </div>
      </div>
    </div>
  );
};

export default PrescriptioCostCalculator;