import React from 'react';
import { Medication, Dosage } from '../../helpers/types';

interface Props {
  medications: Medication[];
  selectedMed: Medication | null;
  onSelectMed: (id: number) => void;
  dosages: Dosage[];
  onSelectDosage: (id: number) => void;
  selectedDosage: Dosage | null;
  duration: number;
  onSetDuration: (duration: number) => void;
  handleAddMedication: () => void
}

export const MedicationSelector: React.FC<Props> = ({
  medications,
  selectedMed,
  onSelectMed,
  dosages,
  onSelectDosage,
  selectedDosage,
  duration,
  onSetDuration,
  handleAddMedication,
}) => {
  return (
    <div className="space-y-4 p-4 bg-gray-50 rounded-lg shadow">
      <div>
        <label className="block text-sm font-medium text-black">
          Select Medication
        </label>
        <select
          className="mt-1 h-10 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
          value={selectedMed?.id || ''}
          onChange={(e) => onSelectMed(parseInt(e.target.value))}
        >
          <option value="">Select a medication...</option>
          {medications.map(med => (
            <option key={med.id} value={med.id}>{med.name}</option>
          ))}
        </select>
      </div>

      <div>
        <label className="block text-sm font-medium text-black">
          Select Dosage
        </label>
        <select
          className="mt-1 h-10 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
          value={selectedDosage?.id || ''}
          onChange={(e) => onSelectDosage(parseInt(e.target.value))}
        >
          <option value="">Select a dosage...</option>
          {dosages?.map(dosage => (
            <option key={dosage.id} value={dosage.id}>
              {dosage.amount} - {dosage.frequency}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label className="block text-sm font-medium text-black">
          Duration (days)
        </label>
        <input
          type="number"
          min="1"
          value={duration}
          onChange={(e) => onSetDuration(parseInt(e.target.value))}
          className="mt-1 h-10 pl-2 block w-full rounded-md border-gray-300 shadow-sm focus:border-yellow-500 focus:ring-yellow-500"
        />
        <h4 className='pt-4'>Unit price: {selectedDosage?.unit_price || 0}</h4>
      </div>


      <button
        onClick={handleAddMedication}
        disabled={!selectedMed || !selectedDosage}
        className="w-full px-4 py-2 bg-yellow-400 text-black rounded-md hover:bg-yellow-500 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
      >
        Add Medication
      </button>
    </div>
  );
};