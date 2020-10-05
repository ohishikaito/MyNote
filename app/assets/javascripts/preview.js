$(function () {
  // previewボタンが押されたらイベント発火
  $("#preview").on("click", function () {
    var text = $("#md-textarea").val();
    if (text == "") {
      return;
    }
    if ($("#md-textarea").val().length > 1000) {
      alert("本文を1,000文字以内で入力してください。");
      return false;
    }
    // ajax通信を開始。
    $.ajax({
      url: "/api/tweets/preview", //apiフォルダのtweetsコントローラーのpreviewメソッドを参照
      type: "GET",
      dataType: "json",
      data: { text: text },
    })
      .done(function (html) {
        // ajax成功したら、テキストエリアを非表示にする。
        $("#md-textarea").parent().css("display", "none");
        $("#preview-area").show().empty().append(html.text);
        // markdownボタンとpreviewボタンのdisabledを入れ替える。
        $("#markdown").removeClass("disabled");
        $("#preview").addClass("disabled");
      })
      .fail(function () {
        alert("1,000文字以内で入力してください。");
      });
  });

  // markdownボタンが押されたらイベント発火
  $("#markdown").on("click", function () {
    $("#md-textarea").parent().css("display", "");
    $("#preview-area").hide();
    $("#preview").removeClass("disabled");
    $("#markdown").addClass("disabled");
  });
});
