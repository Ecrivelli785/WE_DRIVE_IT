import "bootstrap";
import "../plugins/flatpickr"
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initDateTime } from '../plugins/init_date_time';
import { reviewRater } from '../plugins/init_rater';

initMapbox();
initDateTime();
initAutocomplete();
reviewRater();
