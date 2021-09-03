$('.like, .dislike').on('click', function() {
  event.preventDefault();
  $('.active').removeClass('active');
  $(this).addClass('active');
});