var currentQuestion = 0,
    questionsCount;

const begginText = document.getElementById("quizText");
const startButton = document.getElementById("quizStart");


const initQuiz = () => {
  const quiz = document.getElementById('quiz');
  if (quiz) {
    questionsCount = quiz.dataset.questions;
    showQuestion(currentQuestion); // Display the current tab
    const nextButton = document.getElementById("nextQ")

    nextButton.addEventListener('click', (e) => {
      e.preventDefault();
      nextQuestion(currentQuestion);
    });


    // hide startbutton
    quizContent.classList.add('d-none');
    quizHeader.classList.add('d-none');


    // show nextbutton
    quiz.classList.remove('d-none');

  }
}


if (startButton) {
  startButton.addEventListener('click', initQuiz );
}

function showQuestion(n) {
  // This function will display the specified tab of the form ...
  var questions = document.getElementsByClassName("card");
  if (n > 0) {
    questions[n-1].classList.remove("d-block");
    questions[n-1].classList.add("d-none");
  }

  if (n < questionsCount ) {
    questions[n].classList.add("d-block");
    questions[n].classList.remove("d-none");
  }

  // ... and fix the Previous/Next buttons:
  // if (n == 0) {
  //   document.getElementById("prevBtn").style.display = "none";
  // } else {
  //   document.getElementById("prevBtn").style.display = "inline";
  // }
  // if (n == (x.length - 1)) {
  //   document.getElementById("nextBtn").innerHTML = "Submit";
  // } else {
  //   document.getElementById("nextBtn").innerHTML = "Next";
  // }
  // ... and run a function that displays the correct step indicator:
  // fixStepIndicator(n)
}

function nextQuestion(n) {
  // This function will figure out which tab to display
  // var x = document.getElementsByClassName("tab");
  // Exit the function if any field in the current tab is invalid:
  // if (n == 1 && !validateForm()) return false;
  // Hide the current tab:
  // x[currentQuestion].style.display = "none";
  // Increase or decrease the current tab by 1:
  // currentQuestion = currentQuestion + n;
  currentQuestion++

  if (n == questionsCount - 1 ) {
    document.getElementById("nextQ").classList.add("d-none");
    document.getElementById("submitButton").classList.remove("d-none");
  }


  // if you have reached the end of the form... :
  // if (currentQuestion >= x.length) {
  //   //...the form gets submitted:
  //   document.getElementById("regForm").submit();
  //   return false;
  // }
  // Otherwise, display the correct tab:
  showQuestion(currentQuestion);


}

// function validateForm() {
//   // This function deals with validation of the form fields
//   var x, y, i, valid = true;
//   x = document.getElementsByClassName("tab");
//   y = x[currentQuestion].getElementsByTagName("input");
//   // A loop that checks every input field in the current tab:
//   for (i = 0; i < y.length; i++) {
//     // If a field is empty...
//     if (y[i].value == "") {
//       // add an "invalid" class to the field:
//       y[i].className += " invalid";
//       // and set the current valid status to false:
//       valid = false;
//     }
//   }
//   // If the valid status is true, mark the step as finished and valid:
//   if (valid) {
//     document.getElementsByClassName("step")[currentQuestion].className += " finish";
//   }
//   return valid; // return the valid status
// }

// function fixStepIndicator(n) {
//   // This function removes the "active" class of all steps...
//   var i, x = document.getElementsByClassName("step");
//   for (i = 0; i < x.length; i++) {
//     x[i].className = x[i].className.replace(" active", "");
//   }
//   //... and adds the "active" class to the current step:
//   x[n].className += " active";
// }


export { initQuiz };
