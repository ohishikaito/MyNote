$(function () {
  // それぞれの変数を定義
  var nt_left = $(".notification-top__title__left");
  var nt_right = $(".notification-top__title__right");
  var nt_items = $(".notification-top__items");
  var nt_activities = $(".notification-top__activities");

  // 左側（通知欄）をクリックしたら、左側に適切なクラスを除外＆追加する。同時に右側に適切なクラスを除外＆追加。
  nt_left.click(function () {
    nt_items.fadeIn(0);
    nt_activities.fadeOut(0);
    nt_left.addClass("notification-top__title--show");
    nt_left.removeClass("notification-top__title--down");
    nt_right.removeClass("notification-top__title--show");
    nt_right.addClass("notification-top__title--down");
  });

  // 右側（自分の行動）をクリックしたら、右側に適切なクラスを除外＆追加する。同時に左側に適切なクラスを除外＆追加。
  nt_right.click(function () {
    nt_items.fadeOut(0);
    nt_activities.fadeIn(0);
    nt_right.addClass("notification-top__title--show");
    nt_right.removeClass("notification-top__title--down");
    nt_left.removeClass("notification-top__title--show");
    nt_left.addClass("notification-top__title--down");
  });
});
