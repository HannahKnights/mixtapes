$(document).ready ->
  $('#new_track').on 'submit', (event) ->
    event.preventDefault()
    
    $.post $(this).attr('action'), $(this).serialize(), (track) ->
      trackHTML = Mustache.render $('#playlist-template').html(), track

      $('.track-listing').append(trackHTML)