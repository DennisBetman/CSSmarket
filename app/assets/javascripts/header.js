var toggleMenu = function(e) {
  e.preventDefault("");

  var menu = $("[data-menu]");
  var overlay = $("[data-overlay]");

  overlay.toggleClass("overlay--is-active");
  menu.toggleClass("menu--is-active");
};

$(document).on("click", "[data-menu-toggle]", toggleMenu);
