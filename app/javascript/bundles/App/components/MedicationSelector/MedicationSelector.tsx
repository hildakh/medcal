import React, { memo } from 'react';
import { Medication } from '../../helpers/types';

interface Props {
  medications: Medication[];
  onSelectMed: (id: number) => void;
  selectedMed: Medication | null;
}

export const MedicationSelector: React.FC<Props> = memo(({
  medications,
  onSelectMed,
  selectedMed,
}) => {
  return (
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
  );
});