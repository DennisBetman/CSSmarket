function imageBannerPreview(input) {
  var reader = new FileReader();
  //Check the image size;
  if(input.files[0].size > 1000000) {
    $(".image__error--banner").html("The image size has to be less than 1MB");
  } else {
    reader.onload = function(e) {
      $('.image__placeholder--banner').attr('src', " ");
      $('.image__placeholder--banner').css({"display": "block"}).attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).on('change', '.form__input--upload-image', function (e) {

  //Remove the error;
  $(".image__error--banner").removeClass('image__error--is-active');

  var data = this,
      _URL = window.URL || window.webkitURL,
      file, imgUpload;

  if($(this).val() === "") {
    //Valid JPG of JPEG;
    if ((file = data.files[0])) {
       imgUpload = new Image();
       imgUpload.onload = function () {
         //Show the preview;
         if(this.width === 1584 && this.height === 912) {
           imageBannerPreview(data);
         } else {
           $(".image__error--banner").addClass("image__error--is-active").html("Make sure that the image has the correct size (1584X912)");
         }
       };
       imgUpload.src = _URL.createObjectURL(file);
    }
  } else {
    //Image check JPG of JPEG;
    var fileExtension = ['jpeg', 'jpg'];
    if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
      //Error if non JPG of JPEG;
      $(".image__error--banner").addClass("image__error--is-active").html("Only formats are allowed : "+fileExtension.join(', '));
    } else {
      //Valid JPG of JPEG;
      if ((file = data.files[0])) {
         imgUpload = new Image();
         imgUpload.onload = function () {
           //Show the preview;
           if(this.width === 1584 && this.height === 912) {
             imageBannerPreview(data);
           } else {
             $(".image__error--banner").addClass("image__error--is-active").html("Make sure that the image has the correct size (1584X912)");
           }
         };
         imgUpload.src = _URL.createObjectURL(file);
      }
    }
  }
});

$(document).on('click', '.image__banner-upload', function() {
  $(".form__input--upload-image").trigger('click');
});


function imageThumbnailPreview(input) {
  var reader = new FileReader();
  //Check the image size;
  if(input.files[0].size > 1000000) {
    $(".image__error--thumb").html("Image can't be bigger than 1MB");
  } else {
    reader.onload = function(e) {
      $('.image__placeholder-thumb').attr('src', " ");
      $('.image__placeholder-thumb').css({"display": "block"}).attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).on('change', '.form__input--upload-thumbnail', function (e) {

  //Remove the error;
  $(".image__error--thumb").removeClass('image__error--is-active');

  var data = this,
      _URL = window.URL || window.webkitURL,
      file, imgUpload;

  if($(this).val() === "") {
    //Valid JPG of JPEG;
    if ((file = data.files[0])) {
       imgUpload = new Image();
       imgUpload.onload = function () {
         //Show the preview;
         if(this.width === 562 && this.height === 562) {
           imageThumbnailPreview(data);
         } else {
           $(".image__error--thumb").addClass("image__error--is-active").html("Image needs to be 562X562");
         }
       };
       imgUpload.src = _URL.createObjectURL(file);
    }
  } else {
    //Image check JPG of JPEG;
    var fileExtension = ['jpeg', 'jpg'];
    if ($.inArray($(this).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
      //Error if non JPG of JPEG;
      $(".image__error--thumb").addClass("image__error--is-active").html("Only " + fileExtension.join(', ') + " allowed");
    } else {
      //Valid JPG of JPEG;
      if ((file = data.files[0])) {
         imgUpload = new Image();
         imgUpload.onload = function () {
           //Show the preview;
           if(this.width === 562 && this.height === 562) {
             imageThumbnailPreview(data);
           } else {
             $(".image__error--thumb").addClass("image__error--is-active").html("Image needs to be 562X562");
           }
         };
         imgUpload.src = _URL.createObjectURL(file);
      }
    }
  }
});

$(document).on('click', '.image__thumbnail', function() {
  $(".form__input--upload-thumbnail").trigger('click');
});

//Preview upload;
function showUploadFileName(value, className) {
  value = value.replace(/C:\\fakepath\\/i, '');
  $("." + className).html(value);
}

$(document).on('click', '.button--preview', function() {
  $(".form__input--preview").trigger('click');
});

$(document).on('change', '.form__input--preview', function (e) {
  var value = $(this).val();
  showUploadFileName(value, "button__upload-file--preview");
});

$(document).on('click', '.button--project', function() {
  $(".form__input--project").trigger('click');
});

$(document).on('change', '.form__input--project', function (e) {
  var value = $(this).val();
  showUploadFileName(value, "button__upload-file--project");
});
