import React from 'react';

interface Props {
  handleAddMedication: () => void,
  isDisabled: boolean
}
const AddMedicationButton: React.FC<Props> = ({
  handleAddMedication,
  isDisabled,
}) => {
  return (
    <button
      onClick={handleAddMedication}
      disabled={isDisabled}
      className="w-full px-4 py-2 bg-yellow-400 text-black rounded-md hover:bg-yellow-500 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
    >
      Add Medication
    </button>
  );
};

export default AddMedicationButton;