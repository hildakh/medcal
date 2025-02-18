import React, { useState } from 'react';
import { Medication, Dosage, SelectedMedication } from '../../helpers/types';
import { medications } from '../../helpers/medications';

interface Props {
  onSelect: (selection: SelectedMedication) => void;
}

export const MedicationSelector: React.FC<Props> = ({ onSelect }) => {
  const [selectedMed, setSelectedMed] = useState<Medication | null>(null);
  const [dosages, setDosages] = useState<Dosage[] | null>(null);
  const [selectedDosage, setSelectedDosage] = useState<Dosage | null>(null);
  const [duration, setDuration] = useState<number>(30);

  const handleMedChange = (medId: string) => {
    const med = medications.find(m => m.id === parseInt(medId));

    if (med) {
      setSelectedMed(med);
      setDosages(med.dosages)
    }
  };

  const handleDosageChange = (dosageId: string) => {
    if (!selectedMed) return;
    const dosage = selectedMed.dosages.find(d => d.id === parseInt(dosageId));

    if (dosage) {
      setSelectedDosage(dosage);
      setDuration(dosage.duration);
    }
  };

  const handleAdd = () => {
    if (selectedMed && selectedDosage) {
      onSelect({
        medication: selectedMed,
        dosage: selectedDosage,
        duration
      });
      setSelectedMed(null);
      setSelectedDosage(null);
      setDuration(30);
    }
  };

  return (
    <div className="space-y-4 p-4 bg-gray-50 rounded-lg shadow">
      <div>
        <label className="block text-sm font-medium text-black">
          Select Medication
        </label>
        <select
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
          value={selectedMed?.id || ''}
          onChange={(e) => handleMedChange(e.target.value)}
        >
          <option value="">Select a medication...</option>
          {medications.map(med => (
            <option key={med.id} value={med.id}>{med.name}</option>
          ))}
        </select>
      </div>

      {selectedMed && (
        <div>
          <label className="block text-sm font-medium text-black">
            Select Dosage
          </label>
          <select
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
            value={selectedDosage?.id || ''}
            onChange={(e) => handleDosageChange(e.target.value)}
          >
            <option value="">Select a dosage...</option>
            {dosages?.map(dosage => (
              <option key={dosage.id} value={dosage.id}>
                {dosage.amount} - {dosage.frequency.name}
              </option>
            ))}
          </select>
        </div>
      )}

      {selectedDosage && (
        <div>
          <label className="block text-sm font-medium text-black">
            Duration (days)
          </label>
          <input
            type="number"
            min="1"
            value={duration}
            onChange={(e) => setDuration(parseInt(e.target.value))}
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
          />
        </div>
      )}

      <button
        onClick={handleAdd}
        disabled={!selectedMed || !selectedDosage}
        className="w-full px-4 py-2 bg-yellow-400 text-black rounded-md hover:bg-yellow-500 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
      >
        Add Medication
      </button>
    </div>
  );
};