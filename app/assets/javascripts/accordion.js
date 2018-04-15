$(document).on('turbolinks:load', function() {
  var totalAcc = $(".accordion__item").length;

  //calc;
  if(totalAcc == 1) {
    $(".accordion__header").addClass("accordion__header--selected");
    $(".accordion__content").css({"height": "auto"});
    $(".accordion__arrow").remove();
  }
});

$(document).on('click', '.accordion__header', function () {
  var totalAcc = $(".accordion__item").length;

  if(totalAcc > 1) {
    if($(this).hasClass('accordion__header--selected')) {
      var getInner = $(this).next().find('.accordion__innerContent').outerHeight();
      $(this).next().css({"height": getInner});

      //Remove height;
      setTimeout(function () {
        $(".accordion__header").removeClass("accordion__header--selected");
        $(".accordion__content").css({"height": 0});
      }, 1);
    } else {
      //Remove all heights;
      $(".accordion__header").removeClass("accordion__header--selected");
      $(".accordion__content").css({"height": 0});

      //Add height to selected;
      $(this).addClass("accordion__header--selected");
      var getInner = $(this).next().find('.accordion__innerContent').outerHeight();
      $(this).next().css({"height": getInner});

      setTimeout(function () {
        $(".accordion__header--selected").next().css({"height": "auto"});
      }, 200);
    }
  }
});
