$(function () {
  // URLがtweets/newかeditならtrue
  if (
    document.location.href.match(/\/tweets\/new/) ||
    document.location.href.match(/\/tweets\/\d+\/edit/)
  ) {
    var i, len, ref, results, tag; // 変数を定義

    $("#tweet-tags").tagit({
      // tagitを発火
      fieldName: "tweet[tag_list]", // paramterの値をtag_listに指定。これでcontrollerで受け取れるようにする。
      singleField: true,
      availableTags: gon.available_tags, // オートコンプリートを有効にする
    });
    // 既存のタグがあれば表示させる
    if (gon.tweet_tags != null) {
      ref = gon.tweet_tags;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        tag = ref[i];
        results.push($("#tweet-tags").tagit("createTag", tag));
      }
      return results;
    }
  }
});
