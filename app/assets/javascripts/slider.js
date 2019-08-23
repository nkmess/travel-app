document.addEventListener('turbolinks:load', function() { 
  $(function(){
    $('.freespace__sliderbox').slick({
      autoplay:true,
      autoplaySpeed:3000,
      fade: true,
    });
  });
});
