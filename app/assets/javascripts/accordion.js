$(document).on('turbolinks:load', function() {
  var totalAccDesktop = $(".post__aside .accordion__item").length;
  var totalAccMobile = $(".post__actions .accordion__item").length;

  //calc;
  if(totalAccDesktop == 1 && totalAccMobile == 1) {
    $(".accordion__header").addClass("accordion__header--selected");
    $(".accordion__content").css({"height": "auto"});
    $(".accordion__arrow").remove();
  }
});
$(document).on('click', '.accordion__header', function () {
  var totalAccDesktop = $(".post__aside .accordion__item").length;
  var totalAccMobile = $(".post__actions .accordion__item").length;

  if(totalAccDesktop > 1 && totalAccMobile > 1) {
    if($(this).hasClass('accordion__header--selected')) {
      var getInner = $(this).next().find('.accordion__inner-content').outerHeight();
      $(this).next().css({"height": getInner});

      //Remove height;
      setTimeout(function () {
        $(".accordion__header").removeClass("accordion__header--selected");
        $(".accordion__content").css({"height": 0});
      }, 1);
    } else {
      //Remove all heights;
      var $this = $(this);

      $(".accordion__header--selected").each(function () {
        var getHeight = $(this).parent().find('.accordion__inner-content').outerHeight();
        $(".accordion__content").css({"height": getHeight});
      });

      setTimeout(function () {
        $(".accordion__header--selected").parent().find(".accordion__content").css({"height": 0});
        $(".accordion__header--selected").removeClass("accordion__header--selected");

        //Add height to selected;
        $this.addClass("accordion__header--selected");
        var getInner = $this.parent().find('.accordion__inner-content').outerHeight();
        $this.next().css({"height": getInner});
      }, 10);

      setTimeout(function () {
        $(".accordion__header--selected").next().css({"height": "auto"});
      }, 200);
    }
  }
});
