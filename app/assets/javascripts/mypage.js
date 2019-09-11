document.addEventListener('turbolinks:load', function() { 
  $(function(){
    $('.mypage__top__all-posts').click(function(){
      $(this).css('color', 'black');
      $('.mypage__top__liked-posts').css('color', 'gray');
      $('#user__posts').css('display', 'block');
      $('#liked__posts').css('display', 'none');
    })
  
    $('.mypage__top__liked-posts').click(function(){
      $(this).css('color', 'black');
      $('.mypage__top__all-posts').css('color', 'gray');
      $('#user__posts').css('display', 'none');
      $('#liked__posts').css('display', 'block');
    })
  
  });
});
