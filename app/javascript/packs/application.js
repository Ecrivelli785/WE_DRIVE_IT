import "bootstrap";
import "../plugins/flatpickr"

import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

import  { initAutocomplete } from '../plugins/init_autocomplete';

import  { initDateTime } from '../plugins/init_date_time';

initMapbox();
initDateTime();
initAutocomplete();
