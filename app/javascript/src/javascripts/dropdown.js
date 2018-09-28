$(document).on("click", "[data-role='toggle-dropdown']", function(e) {
  e.preventDefault();

  const dropdown = $(this).parents("[data-role='dropdown']");
  dropdown.toggleClass("dropdown--is-active");
});
