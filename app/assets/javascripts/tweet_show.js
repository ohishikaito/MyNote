$(function () {
  $(document).on('click', '.donation-btn', function () {
    $('.donation').fadeToggle();
  });
  $('.donation-modal--close').click(function () {
    $('.donation').fadeToggle();
  });
  $(document).on('submit', '#donation-form', function () {
    if ($(".donation-modal--body--input").val() == 0) {
      alert("1円以上で入力してください");
    }
    $('.donation').fadeToggle();
  });

  $('.tweet-show__content__like--link').on('click', function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });
  $('.tweet-show__content__like--close').click(function () {
    $('.tweet-show__content__like--bgc').fadeToggle();
  });

});