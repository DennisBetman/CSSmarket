if $("[data-role~='markdown']").length != 0
  simplemde = new SimpleMDE(
    element: $("#markdown")[0]
    spellChecker: false)
