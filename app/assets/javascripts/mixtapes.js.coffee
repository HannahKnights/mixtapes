$(document).ready ->
  $('#new_track').on 'submit', (event) ->
    event.preventDefault()
    
  $.post $(this).attr('action'), $(this).serialize(), response ->
    $('.artist_name').html(response.artist) 
    $('.song_title').html(response.song) 
    


