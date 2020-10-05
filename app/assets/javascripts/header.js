$(function () {
  // ヘッダーのリンクをクリックしたら、リストを表示させる。
  $(".header-top__right__user__info--link").click(function () {
    $(".header-top__box").slideToggle(0);
  });
});
