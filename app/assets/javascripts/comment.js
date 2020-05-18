// $(function () {
//   function buildHTML(comment) {
//     var html = `<p>
//                   <strong>
//                     <a href=/users/${comment.user_id}>${comment.user_name}</a>
//                   </strong>
//                   ${comment.content}
//                   ${comment.updated_at}
//                 </p>`;
//     return html;
//   }
//   $("#new_comment").on("submit", function (e) {
//     e.preventDefault();
//     var formData = new FormData(this);
//     var url = $(this).attr("action");
//     console.log(formData);
//     $.ajax({
//       url: url,
//       type: "POST",
//       data: formData,
//       dataType: "json",
//       processData: false,
//       contentType: false,
//     })
//       .done(function (comment) {
//         var html = buildHTML(comment);
//         $("#js-table-comment").append(html);
//         $(".textbox").val("");
//         $(".form__submit").prop("disabled", false);
//       })
//       .fail(function () {
//         alert("error");
//       });
//   });
// });
