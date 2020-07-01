$(function () {
  $fileField = $('#file')

  // 選択された画像を取得し表示
  $($fileField).on('change', $fileField, function (e) {
    file = e.target.files[0]
    reader = new FileReader(),
      $preview = $("#img_field");

    reader.onload = (function (file) {
      return function (e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "100%",
          class: "tweet-form__bonus__preview--image",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });

  $("#md-textarea").keyup(function () {
    $("#tweet-text-count").text($(this).val().length + '/1000');
  });

  if (document.location.href.match(/\/tweets\/\d/)) {
    $("#tweet-text-count").text($("#md-textarea").val().length + '/1000');
  }
  console.log($("#md-textarea").val().length);

  $("#tweet-form").submit(function () {
    if ($("#md-textarea").val().length > 1000) {
      alert('本文を1,000文字以内で入力してください。');
      return false;
    }
  });

  // 実装予定のタグ検索機能です！
  // $("#tag-submit").on("click", function () {
  //   let input = $("#tag-input").val();
  //   window.location.href = `http://localhost:3000/tweets?tag_name=${input}`
  // });

});

