import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelectorAll(".ride_address");


  if (addressInput) {
    addressInput.forEach((input) => {
      places({
        container: input,
        // TODO: get from .env
        appId: 'plURO0PTZUUG',
        apiKey: '886e6b850e09a8b1e7086ef43ef3eac6',
      });
    })
  }
};

export { initAutocomplete };
