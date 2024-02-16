/*
Feedback Buttons
*/

const yesButton = document.querySelector('.feedback-yes');
const noButton = document.querySelector('.feedback-no');

const disableButtons = () => {
  yesButton.disabled = true;
  noButton.disabled = true;
};

function thanksFeedback(button){
  button.blur();
  buttonText = button.innerText
  button.innerText = 'Thanks for the feedback!'
  setTimeout(function () {
    button.innerText = buttonText;
  }, 2000);
}

const sendFeedback = (value) => {
  if (typeof ga !== 'function') return;
  const args = {
    command: 'send',
    hitType: 'event',
    category: 'Feedback Buttons',
    action: 'click',
    label: window.location.pathname,
    value: value
  };
  ga(args.command, args.hitType, args.category, args.action, args.label, args.value);
};

if (yesButton !== null ) {
  yesButton.addEventListener('click', () => {
    thanksFeedback(yesButton);
    disableButtons();
    sendFeedback(1);
  });
}

if (noButton !== null ) {
  noButton.addEventListener('click', () => {
    thanksFeedback(noButton);
    disableButtons();
    sendFeedback(0);
  });
}

/*
Feedback Form
*/

const feedbackCharactersMinimumId = $("#feedback-min-characters");
const feedbackButtonId = $("#feedback-form-submit-feedback");
const feedbackId = $("#feedback-form-feedback");
const minFeedbackLength = 1

/*
function feedbackLength()
feedback-form-feedback input requires 1 character minimum
Submit button feedback-form-submit-feedback is disabled until min character requirement is met
*/

function feedbackLength(){
  const feedbackLength = feedbackId.val().length;

  if (feedbackLength >= minFeedbackLength){
    feedbackButtonId.prop("disabled", false);
  } else {
    feedbackButtonId.prop("disabled", true);
  }
}

/*
function submitContactFormFeedback
Submit data to AWS from feedback-form
On successful submit:
- show success message
- reset text in feedback-form-feedback
- reset text in feedback-form-email
- disable submit button feedback-form-submit-feedback
On failed submit:
- show failure message
*/
function validate(event)  {
  event.preventDefault();
  grecaptcha.execute();
}

function submitContactFormFeedback(event) {

  const reCaptchaResponse = grecaptcha.getResponse();
  const responseMessageId = $("#feedback-form-thank-you-message");

  const feedback = feedbackId.val();
  const pageUrl = $("#feedback-form-page-url").val();
  const ghUrl = $("#feedback-form-gh-url").val();
  const pageTitle = $("#feedback-form-page-title").val();
  const product = $("#feedback-form-chef-product").val();
  const productVersion = $('#feedback-form-chef-product-version').val();
  const data = {
    feedback : feedback,
    pageUrl : pageUrl,
    ghUrl : ghUrl,
    pageTitle : pageTitle,
    product : product,
    reCaptchaResponse : reCaptchaResponse
  };

  // console.log(data);

  $.ajax({
    type: "POST",
    url : "https://nhvuhdbe97.execute-api.us-west-2.amazonaws.com/default/docs-feedback-form",
    dataType: "json",
    crossDomain: "true",
    contentType: "application/json",
    data: JSON.stringify(data),

    success: function () {
      // clear form and show a success message
      // console.log("User input successfully submitted!")
      feedbackId.val("");
      responseMessageId.show();
      feedbackButtonId.prop("disabled", true);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      // show an error message
      // console.log("Failure");
      // console.log(JSON.stringify(jqXHR));
      // console.log("AJAX error: " + textStatus + ' : ' + errorThrown);
      responseMessageId.text("Unsuccessful :( You can also try sending an email to chef-docs@progress.com.");
      responseMessageId.show();
    }
  });
}
