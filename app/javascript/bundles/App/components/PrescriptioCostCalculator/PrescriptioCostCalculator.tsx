import React, { useEffect, useState } from 'react';
import { Prescription, SelectedMedication } from '../../helpers/types';
import { MedicationSelectorContainer } from '../MedicationSelectorContainer/MedicationSelectorContainer';

const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

const PrescriptioCostCalculator: React.FC = () => {
  const [prescriptionItems, setPrescriptionItems] = useState<SelectedMedication[]>([]);
  const [prescription, setPrescription] = useState<Prescription>({
    total_cost: 0,
    budget: 0,
    items: [],
    id: 0
  });

  const [budget, setBudget] = useState(100);

  const handleAddPrescriptionItem = (medication: SelectedMedication): void => {
    setPrescriptionItems([...prescriptionItems, medication]);
  };

  const addPrescriptionItem = async (medication: SelectedMedication) => {
    if (prescription?.id) {
      try {
        const response = await fetch(`/prescriptions/${prescription.id}/prescription_items`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': token || ''
          },
          body: JSON.stringify(medication),
        })

        const data = await response.json();

        setPrescription((prevPrescription) => ({
          ...prevPrescription,
          id: data.id,
          total_cost: data.total_cost,
          items: [ ...prevPrescription?.items || [], data.item],
          budget: data.budget
        }))
      } catch (error) {
        console.error('Error adding items:', error);
      }
    }
  }

  const createPrescription = async (medication: SelectedMedication) => {
    try {
      const response = await fetch(`/prescriptions`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': token || ''
        },
        body: JSON.stringify({
          budget,
          items: [medication],
        }),
      })

      const data = await response.json();

      setPrescription(data);
    } catch (error) {
      console.error('Error creating prescription:', error);
    }
  }

  const updateBudget = async (prescriptionId, newBudget) => {
    try {
      const response = await fetch(`/prescriptions/${prescriptionId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': token || ''
        },
        body: JSON.stringify({ budget: newBudget }),
      });

      const data = await response.json();

      console.log('Updated Prescription:', data);
    } catch (error) {
      console.error('Error updating budget:', error);
    }
  };

  useEffect(() => {
    if (prescription?.id) {
      updateBudget(prescription.id, budget);
    }
  }, [budget]);

  useEffect(() => {
    if (prescriptionItems.length > 0 && !prescription?.id) {
      createPrescription(prescriptionItems[0]);
    } else if (prescriptionItems.length > 0) {
      addPrescriptionItem(prescriptionItems[prescriptionItems.length - 1]);
    }
  }, [prescriptionItems]);


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
                readOnly={!prescription?.id}
              />
            </div>
            <MedicationSelectorContainer
              handleAddPrescriptionItem={handleAddPrescriptionItem}
            />
          </div>

          <div className='prescription-summary col-span-12 md:col-span-6'>
          <div className="bg-gray-50 p-4 rounded-lg shadow">
            <h3>
              Prescription Summary
            </h3>
            {
              prescriptionItems.map((med: SelectedMedication, index) => (
                <div key={med.medication.id+med.dosage.id+index}>
                  <h4 className='border-b py-4'>
                    {med.medication.name} - {med.dosage.amount} - {med.dosage.frequency} - {med.duration} days
                  </h4>
                </div>
              ))
            }
            </div>
            <h3 className='py-4'>Total: ${prescription?.total_cost}</h3>

            <button
              type="submit"
              className="w-full px-4 py-2 bg-yellow-400 text-black rounded-md hover:bg-yellow-500 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
              disabled={prescription?.total_cost > budget || prescriptionItems.length === 0}

            >
              Confirm prescription
            </button>
          </div>

        </div>
      </div>
    </div>
  );
};

export default PrescriptioCostCalculator;