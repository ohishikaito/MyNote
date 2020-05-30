$(function () {
  // $('.donation').dialog({ autoOpen: false });

  // $('.donation-btn').on('click', function () {
  $(document).on('click', '.donation-btn', function () {
    // $('.donation').removeClass('donation');
    // $('.wrapper').addClass('donation');
    // $('.donation').remove();
    // $('.donation').show()
    // $('.donation').fadeToggle();
    $('.donation').fadeToggle();
  });
  $('.donation-modal--close').click(function () {
    $('.donation').fadeToggle();
  });
  $('#donation-form').on('submit', function () {
    // $(document).on('submit', '#donation-form', function () {
    console.log("aa");
    // $('.donation').fadeOut(500);
    // $('.donation').fadeToggle();
    // $('.donation-modal').fadeOut(500);
    // $('.donation').hide();
    // $('.donation-modal--submit--btn').prop("disabled", false);
    // $('.donation-btn').prop("disabled", false);
    // $('.donation').fadeToggle();
  });

  // $('.send-btn').click(function () {
  //   $("#new_post").submit();
  //   $('.modal').fadeOut(500);
  //   $('.wrapper').removeClass('back-ground');
  //   return false;
  // });

  $('.tweet-show__content__like--link').on('click', function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });
  $('.tweet-show__content__like--close').click(function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });

});