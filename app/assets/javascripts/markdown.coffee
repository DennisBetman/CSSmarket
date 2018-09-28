$(document).on "turbolinks:load", ->
  if $("[data-role~='markdown']").length != 0
    simplemde = new SimpleMDE(
      element: $("[data-role~='markdown']")[0]
      spellChecker: false)
