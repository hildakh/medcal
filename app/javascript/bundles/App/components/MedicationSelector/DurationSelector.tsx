import React from 'react';
import { Dosage } from '../../helpers/types';

interface Props {
  duration: number;
  onSetDuration: (duration: number) => void;
  selectedDosage: Dosage | null;
}

const DurationSelector: React.FC<Props> = ({
  duration,
  onSetDuration,
  selectedDosage,
}) => {
  return (
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
  );
};

export default DurationSelector;