$(document).on "submit", "[data-role='remote-submit']", ->
  element = $(this).parents "[data-role='charge-container']"

  element.html "Pending..."
