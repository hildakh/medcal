import React, { memo } from 'react';
import { SelectedMedication } from '../../helpers/types';

interface Props {
  budget: number;
  items: SelectedMedication[];
  onSubmit: () => Promise<void>;
  totalCost: number;
}

const PrescriptioSummary: React.FC<Props> = memo(({
  budget,
  items,
  onSubmit,
  totalCost,
}) => {
  return (
    <div className='prescription-summary col-span-12 md:col-span-6'>
    <div className="bg-gray-50 p-4 rounded-lg shadow">
    <h3>
      Prescription Summary
    </h3>
    {
      items.map((med: SelectedMedication, index) => (
        <div key={med.medication.id+med.dosage.id+index}>
          <h4 className='border-b py-4'>
            {med.medication.name} - {med.dosage.amount} - {med.dosage.frequency} - {med.duration} days
          </h4>
        </div>
      ))
    }
    </div>
    <h3 className='py-4'>Total: ${totalCost}</h3>

    <button
      type="submit"
      className="w-full px-4 py-2 bg-yellow-400 text-black rounded-md hover:bg-yellow-500 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
      disabled={totalCost > budget || items.length === 0}
      onClick={onSubmit}
    >
      Confirm prescription
    </button>
  </div>
  );
});

export default PrescriptioSummary;