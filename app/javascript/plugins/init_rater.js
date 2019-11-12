import rater from 'rater-js';

const reviewRater = () => {

  const starReview = document.querySelector("#rater");

  rater({
    element: starReview,
    rateCallback:function rateCallback(rating, done) {
      this.setRating(rating);
      document.getElementById('review_rating').value = rating;
      done();
    },
    starSize:40
  });

};

export { reviewRater };
