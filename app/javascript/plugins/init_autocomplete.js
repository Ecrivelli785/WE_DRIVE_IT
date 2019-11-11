import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelectorAll(".ride_address");


  if (addressInput) {
    addressInput.forEach((input) => {
      places({ container: input });
    })
  }
};


export { initAutocomplete };
