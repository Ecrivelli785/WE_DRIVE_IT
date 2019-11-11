import mapboxgl from 'mapbox-gl';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'


const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, duration: 0, zoom: 4, center: [-58.37723, -34.61315] });
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();

    const directions = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/driving',
      controls: {
        inputs: false,
        instructions: false,
        profileSwitcher: true
      }
    });

    map.addControl(directions, 'top-left');

    // Add geolocate control to the map.
    map.addControl(new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      trackUserLocation: true
    }));
      // directions.setOrigin("Santa Fe, Argentina");
      // directions.setDestination("Buenos Aires, Argentina");


    const markers = JSON.parse(mapElement.dataset.markers);
    if (markers) {
      addMarkersToMap(map, markers);
      fitMapToMarkers(map, markers);
    }


map.on('load', () => {


    if (serviceType != "One way trip") {

      const originAddress = document.getElementById("ride_steps_attributes_0_address")
      const firstPlaceAddress = document.getElementById("ride_steps_attributes_1_address")
      const returnAddress = document.getElementById("ride_steps_attributes_2_address")


      originAddress.addEventListener('focusout', (event) => {
        directions.setOrigin(event.target.value);
        console.log(directions.getWaypoints())
      });

      firstPlaceAddress.addEventListener('focusout', (event) => {
        directions.setDestination(event.target.value);
        console.log(event)
        console.log(directions.getWaypoints())
      });

      returnAddress.addEventListener('focusout', (event) => {
        directions.setDestination(event.target.value);
        console.log(directions.getWaypoints())
      });
    } else {

      const originAddress = document.getElementById("ride_steps_attributes_0_address")
      const destinationAddress = document.getElementById("ride_steps_attributes_1_address")

      originAddress.addEventListener('focusout', (event) => {
        directions.setOrigin(event.target.value);
      });

      destinationAddress.addEventListener('focusout', (event) => {
        directions.setDestination(event.target.value);
      });
    }
});

  }
};





export { initMapbox };
