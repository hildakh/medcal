import React from 'react';
import { Dosage } from '../../helpers/types';

interface Props {
  dosages: Dosage[];
  onSelectDosage: (id: number) => void;
  selectedDosage: Dosage | null;
}

const DosageSelector: React.FC<Props> = ({
  selectedDosage,
  onSelectDosage,
  dosages,
}) => {
  return (
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
  );
};

export default DosageSelector;