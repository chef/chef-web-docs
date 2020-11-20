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
  //console.log(args.command, args.hitType, args.category, args.action, args.label, args.value)
};


yesButton.addEventListener('click', () => {
  thanksFeedback(yesButton);
  disableButtons();
  sendFeedback(1);
});

noButton.addEventListener('click', () => {
  thanksFeedback(noButton);
  disableButtons();
  sendFeedback(0);
});