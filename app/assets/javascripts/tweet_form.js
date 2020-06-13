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

  $("#tag-submit").on("click", function () {
    let input = $("#tag-input").val();
    window.location.href = `http://localhost:3000/tweets?tag_name=${input}`
  });
  //     .tag_search
  // タグ検索
  //   % input{ type: "text", id: "tag" }
  //       % input{ type: "submit", class: 'tag-submit' }

  //   let tags = ["aa", "bb", "cc"];
  //   let list = $(".tag-form");
  //   function appendList(input) {
  //     let html = `
  //       <input value="${input}" class="tag-form" type="text" name="tweet[tag_list]" id="tweet_tag_list">
  //       `;
  //     return html;
  //   }
  //   list.on("keyup", function () {
  //     let input = list.val();
  //     // let reg = new RegExp("^" + input);
  //     // $.each(tags, function (i, tag) {
  //     //   if (tag.match(reg)) {
  //     //     console.log("ok");
  //     var html = appendList(input);
  //     list.append(html);
  //     // return false;
  //     //     }
  //     //   });
  //     // });
  //   });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#tweet_img").change(function () {
    console.log("aaa");
    readURL(this);
  });
});