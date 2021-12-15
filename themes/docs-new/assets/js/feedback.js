const yesButton = document.querySelector('.feedback-yes');
const noButton = document.querySelector('.feedback-no');
const para = document.querySelector('#feedbackText')

const disableButtons = () => {
  yesButton.disabled = true;
  noButton.disabled = true;
};

function thanksFeedback(para){
  paraText = para.innerText
  para.innerText = 'Thanks for the feedback!'
  setTimeout(function () {
    para.innerText = paraText;
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
