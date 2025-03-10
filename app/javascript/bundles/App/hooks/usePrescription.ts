import { useState } from 'react';
import { SelectedMedication } from '../helpers/types';

export const usePrescription = () => {
  const [prescriptionItems, setPrescriptionItems] = useState<SelectedMedication[]>([]);
  const [budget, setBudget] = useState(100);
  const [totalCost, setTotalCost] = useState(0);
  const [statusMessage, setStatusMessage] = useState('');

  const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

  const getItemCost = async (item: SelectedMedication) => {
    const queryParams = new URLSearchParams({
      medication_id: item.medication.id.toString(),
      dosage_id: item.dosage.id.toString(),
      duration: item.duration.toString()
    });

    const response = await fetch(`/prescription_items/calculate?${queryParams}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      },
    });

    return response.json();
  };

  const createPrescription = async (): Promise<void> => {
    try {
      const response = await fetch('/prescriptions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': token || ''
        },
        body: JSON.stringify({
          budget,
          items: prescriptionItems,
        }),
      })

      const data = await response.json();

      if (data.prescription.id) {
        setStatusMessage('Prescription successfully created');
      } else {
        setStatusMessage('Something went wrong');
      }
    } catch (error) {
      console.error('Error creating prescription:', error);
    }
  }

  const handleAddPrescriptionItem = async (medication: SelectedMedication): Promise<void> => {
    setPrescriptionItems([...prescriptionItems, medication]);
    const itemCost = await getItemCost(medication);

    setTotalCost((prevCost) => prevCost + parseFloat(itemCost.total_cost));
  };

  return {
    budget,
    createPrescription,
    handleAddPrescriptionItem,
    prescriptionItems,
    setBudget,
    totalCost
  }
}