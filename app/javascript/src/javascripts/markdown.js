import SimpleMDE from "simplemde"

$(document).on("turbolinks:load", function() {
  if ($("[data-role~='markdown']").length !== 0) {
    let simplemde = new SimpleMDE({
      element: $("[data-role~='markdown']")[0],
      spellChecker: false
    });
  }
});
