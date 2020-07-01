
$(function () {
  // if (document.location.href.match(/\/tweets\/\d/)) {
  if (document.location.href.match(/\/tweets\/new/) || document.location.href.match(/\/tweets\/\d+\/edit/)) {
    var i, len, ref, results, tag;

    $('#tweet-tags').tagit({
      fieldName: 'tweet[tag_list]',
      singleField: true,
      availableTags: gon.available_tags
    });
    if (gon.tweet_tags != null) {
      ref = gon.tweet_tags;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        tag = ref[i];
        results.push($('#tweet-tags').tagit('createTag', tag));
      }
      return results;
    }
  }
});