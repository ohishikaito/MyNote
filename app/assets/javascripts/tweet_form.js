$(function () {
  $(".tag-submit").on("click", function () {
    let input = $("#tag").val();
    window.location.href = `http://localhost:3000/tweets?tag_name=${input}`
  });
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
});
