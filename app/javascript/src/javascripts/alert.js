$(document).on("click", "[data-role='alert-close']", function() {
  $(this).parents("[data-role='alert']").remove("");
});
