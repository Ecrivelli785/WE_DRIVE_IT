import mapboxgl from 'mapbox-gl';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'


const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

  let options = {
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  }

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)) {
    options["dragPan"] = false;
  }

  return new mapboxgl.Map(options);
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

const renderPrice = (price, time) => {
  // render the total cost of the trip in the html
  const tripPriceWrapper = document.getElementById('render-price');
  const tripPrice = document.getElementById('render-price');
  const priceField = document.getElementById('ride_estimated_price');
  document.getElementById('ride_estimated_price').value = Math.round(price * time);

  // tripPrice.innerText = "$";
  tripPrice.innerText = '$ ' + Math.round(price * time);
  priceField.value = Math.round(price * time);
}


const renderTime = (time) => {
  // render the total time of the trip in the html
  const tripTime = document.getElementById('render-time');
  document.getElementById('ride_estimated_time_ride').value = Math.round(time);
  const timeField = document.getElementById('ride_estimated_time_ride');

  const estimatedTime = Math.round(time);
  tripTime.innerText = `${Math.round(estimatedTime / 60)} hrs ${estimatedTime % 60} mins `;
  timeField.value = estimatedTime;
}

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();

    const directions = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/driving-traffic',
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
            // console.log(directions.getWaypoints())
          });

          firstPlaceAddress.addEventListener('focusout', (event) => {
            directions.setDestination(event.target.value);
            // console.log(event)
            // console.log(directions.getWaypoints())
          });

          returnAddress.addEventListener('focusout', (event) => {
            directions.setDestination(event.target.value);
            // console.log(directions.getWaypoints())
          });
          // Multi way price
          const multiWayPrice = 20;
          const rideDurationTime = directions.on('route', (route) => {
            renderPrice(multiWayPrice, route.route[0].duration / 60)
            renderTime(route.route[0].duration / 3600);

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
          // One way price
          const oneWayPrice = 25;
          const rideDurationTime = directions.on('route', (route) => {
            renderPrice(oneWayPrice, route.route[0].duration / 60);
            renderTime(route.route[0].duration / 60);
          });
        }
    });
  }
};





export { initMapbox };
