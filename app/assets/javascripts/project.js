let updateProjectColor = () => {

  if($(".project").length) {

    let colorThief = new ColorThief()

    $(".project").each((index, element) => {
      let getImageUrl = $(element).attr('data-image')

      if(getImageUrl != "") {

        let imgObj = new Image()
        imgObj.src = getImageUrl
        $(imgObj).load(() => {

          let colors = colorThief.getColor(imgObj)
          let colorR = colors[0]
          let colorG = colors[1]
          let colorB = colors[2]
          $(element).find('.project__gradient').css({"background": "linear-gradient(to top, rgba("+colorR+", "+colorG+", "+colorB+", 1) 50%, rgba(0, 0, 0, 0) 100%)"})

        })

      }
    })

  }

}

$(document).on('turbolinks:load', function() {
  updateProjectColor()
})
