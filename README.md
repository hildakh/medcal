# MedCal

Med Cal is a **prescription cost calculator** that allows users to create prescriptions, add medication items, and calculate the total cost dynamically build on Rails and React. This project uses [React on Rails template](https://github.com/shakacode/react_on_rails) from [Shakacode](https://github.com/shakacode)

## 🚀 Features
- Create prescriptions with a set budget.
- Add prescription items and dynamically calculate total costs.
- Apply discounts for long-duration prescriptions.
- API endpoints for managing prescriptions and medications.

---

## 📦 Installation & Setup
### Clone the Repository
```sh
 git clone https://github.com/hildakh/medcal.git
 cd medcal
```

### Install Dependencies
#### Backend (Rails API)
```sh
bundle install
```

#### Frontend (React & TypeScript)
```sh
yarn install
```

### Setup Database
```sh
bin/rails db:create db:migrate db:seed
```

### Start the Development Server
```sh
foreman start web
```
---

## 🛠 API Endpoints
### Prescriptions
- `POST /prescriptions` – Create a prescription
- `PUT /prescriptions/:id` – Update budget
- `GET /prescriptions/:id` – Retrieve prescription details.

### Prescription Items
- `POST /prescriptions/:prescription_id/prescription_items` – Add an item to a prescription.

### Medications
- `GET /medications` – List available medications.
- `GET /medications/:id` – Get medication details.

---

## 🧪 Running Tests
Run all tests using:
```sh
bundle exec rspec
```

To check for code formatting and linting issues:
```sh
bundle exec rubocop
```

To auto-fix linting issues
```sh
bundle exec rubocop --auto-correct
```
---

## Next steps
  - 🧪 Add specs for controllers & react components
  - 🤖 Feature update
    - Implement cost modification logic in frontend to suggest shorter duration
    - Add confetti / confirmation when prescription is submitted

