$(document).ready(function(){
  $('#new_track').on('submit', function(event){
    event.preventDefault();

    $.post($(this).attr('action'), $(this).serialize(), function(response){
      $('.artist_name').html(response.artist)
      $('.song_title').html(response.song)
    })
  })
});