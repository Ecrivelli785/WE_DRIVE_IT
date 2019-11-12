import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelectorAll(".ride_address");
  // const yourApplicationID = YOUR_APPLICATION_ID.env;
  // const algoliaApiKey = ALGOLIA_API_KEY.env;

  if (addressInput) {
    addressInput.forEach((input) => {
      places({
        container: input,
        // TODO: get from .env
        appId: input.dataset.algoliaAppId,
        apiKey: input.dataset.algoliaAppKey,
      });
    })
  }
};

export { initAutocomplete };
