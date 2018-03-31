$(document).on "click", "[data-role='toggle-dropdown']", (e) ->
  e.preventDefault()

  dropdown = $(this).parents "[data-role='dropdown']"
  dropdown.toggleClass "dropdown--is-active"

$(document).on "click", "[data-role='remote-submit']", ->
  dropdown = $(this).parents "[data-role='dropdown']"
  dropdownToggle = dropdown.find "[data-role='toggle-dropdown']"
  dropdownContent = dropdown.find ".dropdown__content"

  dropdownToggle.text "Pending..."
  dropdownContent.addClass "dropdown__content--submit-pending"
  dropdownContent.append "Pending..."
