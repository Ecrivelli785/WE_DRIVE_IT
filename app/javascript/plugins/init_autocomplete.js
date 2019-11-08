import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('ride_steps_attributes_0_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};


export { initAutocomplete };
