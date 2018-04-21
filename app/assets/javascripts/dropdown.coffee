$(document).on "click", "[data-role='toggle-dropdown']", (e) ->
  e.preventDefault()

  dropdown = $(this).parents "[data-role='dropdown']"
  dropdown.toggleClass "dropdown--is-active"
