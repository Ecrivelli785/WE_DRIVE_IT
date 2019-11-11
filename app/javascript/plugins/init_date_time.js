const initDateTime = () => {

  // Addresses
  const steps = document.querySelectorAll(".ride_address")
  // Date and Time
  const startDate = document.querySelector("#start-date")
  const startTimeHour = document.querySelector("#start-time-hour")
  const startTimeMinute = document.querySelector("#start-time-minute")
  // Date and Time (Multi way)
  const startDate2 = document.querySelector("#start-date-2")
  const startTimeHour2 = document.querySelector("#start-time-hour-2")
  const startTimeMinute2 = document.querySelector("#start-time-minute-2")
  // Actual input of Date and Time
  const inputStartDateTime = document.querySelector("#start_time")
  const inputEndDateTime = document.querySelector("#end_time")
  // Submit button
  const button = document.querySelector("#chofer_request")

  const buildDateTime = (date, hour, minutes) => {
    return `${date} ${hour}:${minutes}`
  }

  const calculateEstimateTime = () => {
    // MAPBOX API
    inputEndDateTime.value = inputStartDateTime.value
  }

  const updateStartDateTime = () => {
    inputStartDateTime.value = buildDateTime(startDate.value, startTimeHour.value, startTimeMinute.value)
    if (startDate2) {
      inputEndDateTime.value = buildDateTime(startDate2.value, startTimeHour2.value, startTimeMinute2.value)
    } else {
      calculateEstimateTime();
    }
  }

  const checkInput = () => {
    if (startDate2) {
     if (startDate.value !== "" && startDate2.value !== "" && Array.from(steps).every(step => step.value !== "")) {
      button.classList.remove("disabled")
      button.disabled = ""
      updateStartDateTime();
     } else {
       button.classList.add("disabled")
       button.disabled = "disabled"
     }
    } else {
     if (startDate.value !== "" && Array.from(steps).every(step => step.value !== "")) {
      button.classList.remove("disabled")
      button.disabled = ""
      updateStartDateTime();
     } else {
       button.classList.add("disabled")
       button.disabled = "disabled"
     }
    }
  }

  if (startDate) {
    startDate.addEventListener("change", (event) => {
      checkInput();
    })
    startTimeHour.addEventListener("change", (event) => {
      checkInput();
    })
    startTimeMinute.addEventListener("change", (event) => {
      checkInput();
    })
    steps.forEach((step) => {
      step.addEventListener("change", (event) => {
        checkInput();
      })
    })
  }

  if (startDate2) {
    startDate2.addEventListener("change", (event) => {
      checkInput();
    })
    startTimeHour2.addEventListener("change", (event) => {
      checkInput();
    })
    startTimeMinute2.addEventListener("change", (event) => {
      checkInput();
    })
  }
}

export { initDateTime };
