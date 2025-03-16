import React, { memo } from 'react';
import { MedicationSelector } from '../MedicationSelector/MedicationSelector';
import { SelectedMedication } from '../../helpers/types';
import DosageSelector from '../MedicationSelector/DosageSelector';
import DurationSelector from '../MedicationSelector/DurationSelector';
import AddMedicationButton from '../MedicationSelector/AddMedicationButton';
import { useMedication } from '../../hooks/useMedication';

interface Props {
  handleAddPrescriptionItem: (medication: SelectedMedication) => void;
}

export const MedicationSelectorContainer: React.FC<Props> = memo(({
  handleAddPrescriptionItem,
}) => {
  const {
    medications,
    handleSelectMed,
    selectedMed,
    dosages,
    handleSelectDosage,
    selectedDosage,
    duration,
    setDuration,
    handleAddMedication,
  } = useMedication(
    handleAddPrescriptionItem
  );

  return (
    <div className="space-y-4 p-4 bg-gray-50 rounded-lg shadow">
      <MedicationSelector
        medications={medications}
        onSelectMed={handleSelectMed}
        selectedMed={selectedMed}
      />
      <DosageSelector
        dosages={dosages}
        onSelectDosage={handleSelectDosage}
        selectedDosage={selectedDosage}
      />
      <DurationSelector
        duration={duration}
        onSetDuration={setDuration}
        selectedDosage={selectedDosage}
      />
      <AddMedicationButton
        handleAddMedication={handleAddMedication}
        isDisabled={!selectedDosage || !selectedMed}
      />
    </div>
  )
});
