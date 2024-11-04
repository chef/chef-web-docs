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
Submit data to Netlify from feedback-form
On successful submit:
- show success message
- reset text in feedback-form-feedback
- disable submit button feedback-form-submit-feedback
On failed submit:
- show failure message
*/


function submitContactFormFeedback(event) {
  event.preventDefault();

  const htmlForm = event.target;
  const formData = new FormData(htmlForm);
  const responseMessageId = $("#feedback-form-thank-you-message");

  fetch("/", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams(formData).toString(),
  })
    .then(() => console.log("Form successfully submitted"))
    .then(() => console.log(formData))
    .then(feedbackId.val(""))
    .then(responseMessageId.show())
    .then(feedbackButtonId.prop("disabled", true))
    .catch((error) => alert(error));
};

const feedbackForm = document.querySelector("#feedback-form");

if (feedbackForm) {
  feedbackForm.addEventListener("submit", submitContactFormFeedback);
}
