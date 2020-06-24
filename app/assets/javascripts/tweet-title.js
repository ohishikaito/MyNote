$(function () {
  // いいねランキングが呼ばれたら表示
  if (document.location.href.match(/\/tweets\/likes/)) {
    $(".tweet-index__title").show();
    $(".tweet-index__title--text").append("人気投稿");
  }

  // タイムラインが呼ばれたら表示
  if (document.location.href.match(/\/users\/\d+\/timeline/)) {
    $(".tweet-index__title").show();
    $(".tweet-index__title--text").append("タイムライン");
  }
})