/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './app/javascript/**/*.{js,jsx,ts,tsx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        yellow: {
          400: '#FACC15',
          500: '#EAB308',
        },
      },
    },
  },
  plugins: []
};