import React, { useEffect, useState } from 'react';
import { MedicationSelector } from '../MedicationSelector/MedicationSelector';
import { Dosage, Medication, SelectedMedication } from '../../helpers/types';

interface Props {
  handleAddPrescriptionItem: (medication: SelectedMedication) => void
}

export const MedicationSelectorContainer: React.FC<Props> = ({
  handleAddPrescriptionItem,
}) => {
    const [medications, setMedications] = useState<Medication[]>([]);
    const [selectedMed, setSelectedMed] = useState<Medication | null>(null);
    const [dosages, setDosages] = useState<Dosage[]>([]);
    const [selectedDosage, setSelectedDosage] = useState<Dosage | null>(null);
    const [duration, setDuration] = useState<number>(0);

    const fetchMedications = async () => {
     try {
       const response = await fetch('/medications.json');
       const data = await response.json();

       setMedications(data);
     } catch (error) {
       console.error('Error fetching medications:', error);
     }
    }

    const fetchMedication = async () => {
      console.log(selectedMed?.id)

      if (!selectedMed) return;

      try {
        const response = await fetch(`/medications/${selectedMed.id}`);
        const data = await response.json();

        setDosages(data.dosages);

      } catch (error) {
        console.error('Error fetching dosages:', error);
      }
    }

    useEffect(() => {
      fetchMedications();
      fetchMedication();
    }, [selectedMed])

  const handleSelectMed = (id: number) => {
    const selectedMed = medications.find(med => med.id === id)!;

    setSelectedMed(selectedMed);
  };

  const handleSelectDosage = (id: number) => {
    const selectedDosage = dosages.find(dos => dos.id === id)!;

    setSelectedDosage(selectedDosage);
    setDuration(selectedDosage.default_duration);
  }

  const handleAddMedication = () => {
    if (!selectedMed || !selectedDosage) return;

    const prescriptionItem: SelectedMedication = {
      medication: selectedMed,
      dosage: selectedDosage,
      duration
    }

    handleAddPrescriptionItem(prescriptionItem);
  };

  return (
    <MedicationSelector
      medications={medications}
      selectedMed={selectedMed}
      onSelectMed={handleSelectMed}
      dosages={dosages}
      onSelectDosage={handleSelectDosage}
      selectedDosage={selectedDosage}
      duration={duration}
      onSetDuration={setDuration}
      handleAddMedication={handleAddMedication}
    />
  )
};
