$(function () {
  $(document).on("click", ".donation-btn", function () {
    $(".donation").fadeIn(200);
  });
  $(".donation-modal--close--btn").click(function () {
    $(".donation").fadeOut(200);
  });
  $(document).on("submit", "#donation-form", function () {
    if ($(".donation-modal--body--input").val() < 1) {
      alert("1円以上で入力してください");
      return;
    } else if ($(".donation-modal--body--input").val() > 999999) {
      alert("100万円以下で入力してください");
      return;
    }
    $(".donation").fadeOut();
  });

  // いいねした人一覧を表示する機能。現在停止中（2020/10/25)
  //   $(".tweet-show__content__like--link").on("click", function () {
  //     $(".tweet-show__content__like--bgc").fadeToggle();
  //   });
  //   $(".tweet-show__content__like--close").click(function () {
  //     $(".tweet-show__content__like--bgc").fadeToggle();
  //   });
});
