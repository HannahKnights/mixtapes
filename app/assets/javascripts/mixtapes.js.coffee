$(document).ready ->

  $('html').on 'click', '.delete-track', (e) ->
    e.preventDefault()
    track = $(this).parent()
    console.log(track)

    $.ajax url: $(this).attr('href'), method: 'delete', success: ->
      track.remove()
      

  $('#new_track').on 'submit', (event) ->
    event.preventDefault()
    
    $.post $(this).attr('action'), $(this).serialize(), (track) ->
      trackHTML = Mustache.render $('#playlist-template').html(), track
      console.log
      $('.track-listing').append(trackHTML)
      $('#track_song').val("")
      $('#track_artist').val("")