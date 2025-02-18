import { Frequency, FrequencyLabel, FrequencyValue, type Medication } from "../helpers/types"

export const medications: Medication[] = [
  {
    id: 1,
    name: "Metformin",
    dosages: [
      {
        id: 1,
        amount: "500 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 30,
        unitPrice: 5.00
      },
      {
        id: 2,
        amount: "500 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 30,
        unitPrice: 5.00
      },
      {
        id: 3,
        amount: "1000 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 30,
        unitPrice: 5.00
      }
    ]
  },
  {
    id: 2,
    name: "Phentermine",
    dosages: [
      {
        id: 1,
        amount: "15 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 14,
        unitPrice: 15.00
      },
      {
        id: 2,
        amount: "30 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 14,
        unitPrice: 15.00
      },
      {
        id: 3,
        amount: "37.5 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 14,
        unitPrice: 15.00
      }
    ]
  },
  {
    id: 3,
    name: "Naltrexone",
    dosages: [
      {
        id: 1,
        amount: "25 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 7,
        unitPrice: 12.00
      },
      {
        id: 2,
        amount: "50 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 28,
        unitPrice: 12.00
      },
      {
        id: 3,
        amount: "50 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 28,
        unitPrice: 12.00
      }
    ]
  },
  {
    id: 4,
    name: "Wellbutrin",
    dosages: [
      {
        id: 1,
        amount: "100 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 14,
        unitPrice: 10.00
      },
      {
        id: 2,
        amount: "150 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 14,
        unitPrice: 10.00
      },
      {
        id: 3,
        amount: "150 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 14,
        unitPrice: 10.00
      }
    ]
  },
  {
    id: 5,
    name: "Topiramate",
    dosages: [
      {
        id: 1,
        amount: "25 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 30,
        unitPrice: 8.00
      },
      {
        id: 2,
        amount: "25 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 30,
        unitPrice: 8.00
      },
      {
        id: 3,
        amount: "50 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 30,
        unitPrice: 8.00
      }
    ]
  },
  {
    id: 6,
    name: "Ozempic",
    dosages: [
      {
        id: 1,
        amount: "0.25 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_WEEKLY],
          value: FrequencyValue.ONCE_WEEKLY
        },
        duration: 28,
        unitPrice: 40.00
      },
      {
        id: 2,
        amount: "0.5 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_WEEKLY],
          value: FrequencyValue.ONCE_WEEKLY
        },
        duration: 28,
        unitPrice: 40.00
      },
      {
        id: 3,
        amount: "1 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_WEEKLY],
          value: FrequencyValue.ONCE_WEEKLY
        },
        duration: 28,
        unitPrice: 40.00
      }
    ]
  },
  {
    id: 7,
    name: "Bupropion",
    dosages: [
      {
        id: 1,
        amount: "75 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 21,
        unitPrice: 2.50
      },
      {
        id: 2,
        amount: "150 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.ONCE_DAILY],
          value: FrequencyValue.ONCE_DAILY
        },
        duration: 21,
        unitPrice: 3.00
      },
      {
        id: 3,
        amount: "150 mg",
        frequency: {
          name: FrequencyLabel[FrequencyValue.TWICE_DAILY],
          value: FrequencyValue.TWICE_DAILY
        },
        duration: 21,
        unitPrice: 3.50
      }
    ]
  }
]
