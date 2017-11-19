$(document).on("click", ".content__button, .actions__question", function() {
  $(".popup").addClass("popup--animation-in");

  //Prevent scrolling
  $("body, html").addClass('body--no-scroll');
});

$(document).on("click", ".popup__close", function() {
  $(".popup").removeClass("popup--animation-in");

  //Add scrolling
  $("body, html").removeClass('body--no-scroll');
});
