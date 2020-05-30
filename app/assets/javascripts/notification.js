$(function () {
  let nt_left = $('.notification-top__title__left');
  let nt_right = $('.notification-top__title__right');
  let nt_items = $('.notification-top__items');
  let nt_activities = $('.notification-top__activities');

  nt_left.click(function () {
    nt_items.fadeIn(0);
    nt_activities.fadeOut(0);
    nt_left.addClass('notification-top__title--show');
    nt_left.removeClass('notification-top__title--down');
    nt_right.removeClass('notification-top__title--show');
    nt_right.addClass('notification-top__title--down');
  });
  nt_right.click(function () {
    nt_items.fadeOut(0);
    nt_activities.fadeIn(0);
    nt_right.addClass('notification-top__title--show');
    nt_right.removeClass('notification-top__title--down');
    nt_left.removeClass('notification-top__title--show');
    nt_left.addClass('notification-top__title--down');
  });
  // $("#room-show__form").submit(function () {
  //   console.log("aa");
  //   $(".room-show__items").animate({ scrollTop: $(".room-show__items")[0].scrollHeight });
  // });
  // $("#room-show__form").submit(function () {
  //   // $(".room-show__items").animate({ scrollTop: $(".room-show__items")[0].scrollHeight });
  //   $(".room-show__items").scrollTop($(".room-show__items")[0].scrollHeight);
  // });

});