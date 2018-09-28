$(document).on "click", "[data-role='alert-close']", ->
  $(this).parents("[data-role='alert']").remove ""
