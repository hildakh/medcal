import React, { useState } from 'react';

const App = () => {
  const [name, setName] = useState('');

  const handleNameChange = (e) => {
    console.log('event', e)
    setName(e.target.value)
  }

  return (
    <div>
      <h3>Hello, {name}!</h3>
      <hr />
      <form>
        <label htmlFor="name">
          Say hello to:
          <input id="name" type="text" value={name} onChange={handleNameChange} />
        </label>
      </form>
    </div>
  );
};

export default App;
