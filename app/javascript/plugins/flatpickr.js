import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!

flatpickr(".datepicker", { enableTime: false, altInput: true, altFormat: "D d-M", minDate: "today" })
