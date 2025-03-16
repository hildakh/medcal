import { useState, useEffect } from "react";
import { Medication, Dosage, SelectedMedication } from "../helpers/types";

export const useMedication = (
  handleAddPrescriptionItem: (
    medication: SelectedMedication,
  ) => void
) => {
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
  };

  const fetchMedication = async () => {
    if (!selectedMed) return;

    try {
      const response = await fetch(`/medications/${selectedMed.id}`);
      const data = await response.json();

      setDosages(data.dosages);

    } catch (error) {
      console.error('Error fetching dosages:', error);
    }
  };

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

    resetValues();
  };

  const resetValues = () => {
    setSelectedMed(null);
    setDosages([]);
    setDuration(0);
  }

  useEffect(() => {
    fetchMedications();
  }, [])

  useEffect(() => {
    fetchMedication();
  }, [selectedMed]);


  return {
    medications,
    handleSelectMed,
    selectedMed,
    dosages,
    handleSelectDosage,
    selectedDosage,
    duration,
    setDuration,
    handleAddMedication,
  }
}