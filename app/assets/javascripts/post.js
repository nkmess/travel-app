document.addEventListener('turbolinks:load', function() { 
  $(function(){

  

    $(document).on("change", "#image__upload", function(e){
      var file = e.target.files[0];
      reader = new FileReader();
  
      $(".post__form__pic__box#img_field").css('display', 'none');
      $('.post__form__pic__preview__new').css('display', 'block');
      reader.onload = function(e) {
        $("#preview").attr('src', e.target.result);
      }
      reader.readAsDataURL(file);
    })
  
  
    $("#country_select").select2();
  
  
  });
});
