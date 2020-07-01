$(function () {
  // $('.donation-btn').on('click', function () {
  $(document).on('click', '.donation-btn', function () {
    // $('.donation').removeClass('donation');
    // $('.wrapper').addClass('donation');
    $('.donation').fadeToggle();
  });
  $('.donation-modal--close').click(function () {
    $('.donation').fadeToggle();
  });
  $('#donation-form').on('submit', function () {
    // $(document).on('submit', '#donation-form', function () {
    $('.donation').fadeOut(500);
    // $('.donation').fadeToggle();
    // $('.donation-modal').fadeOut(500);
    // $('.donation').hide();
    // $('.donation-modal--submit--btn').prop("disabled", false);
    // $('.donation-btn').prop("disabled", false);
    // $('.donation').fadeToggle();
  });

  $('.tweet-show__content__like--link').on('click', function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });
  $('.tweet-show__content__like--close').click(function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });

});