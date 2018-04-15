$(document).on('click', '.accordion__header', function () {

  if($(this).hasClass('accordion__header--selected')) {
    //Remove height;
    $(".accordion__header").removeClass("accordion__header--selected");
    $(".accordion__content").css({"height": 0});
  } else {
    //Remove all heights;
    $(".accordion__header").removeClass("accordion__header--selected");
    $(".accordion__content").css({"height": 0});

    //Add height to selected;
    $(this).addClass("accordion__header--selected");
    var getInner = $(this).next().find('.accordion__innerContent').outerHeight();
    $(this).next().css({"height": getInner});
  }
});
