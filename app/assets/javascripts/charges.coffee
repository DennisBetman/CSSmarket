$(document).on "submit", "[data-role='remote-submit']", ->
  element = $(this).parents "[data-role='charge-container']"

  element.html '<div class="accordion__item">
    <div class="accordion__header accordion__header--selected">
      <div class="accordion__name">
        <div class="name__icon"><i class="material-icons">cached</i></div>
        <div class="name__about">
          <span class="name__price">Pending</span>
          <span class="name__payment">This can take some seconds</span>
        </div>
      </div>
    </div>
    <div class="accordion__content" style="height: auto;">
      <div class="accordion__inner-content accordion__inner-pending">
        <div class="accordion__message">
          <div class="accordion__pending"></div>
        </div>
      </div>
    </div>
  </div>'
