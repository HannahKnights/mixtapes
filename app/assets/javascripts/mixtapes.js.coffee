# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Mustache.compile = (template) ->
  #   Mustache.parse(template);

  #   return (view, partials) ->
  #     Mustache.render(template, view, partials)

  # getArtistData = (query, callback) ->
  #   $.ajax(
  #     url: "http://developer.echonest.com/api/v4/artist/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=5&name=" + query
  #     dataType: "jsonp"
  #   ).success (response) ->
  #     artists = response.response.artists
  #     names = $.map artists, (artist) ->
  #       {name: artist.name}
  #     callback(names)
  # $('#track_artist').typeahead null,
  #   name: "artists"
  #   minLength: 2
  #   displayKey: 'name'
  #   source: getArtistData
  # getSongData = (query, callback) ->
  #   $.ajax(
  #     url: "http://developer.echonest.com/api/v4/song/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=50&title=" + query
  #     dataType: "jsonp"
  #   ).success (response) ->
  #     console.log(response)
  #     songs = response.response.songs
  #     names = $.map songs, (song) ->
  #       datum = { artist_name: song.artist_name, title: song.title }
  #     callback(names)
  # $('#track_song').typeahead null,
  #   name: "songs"
  #   minLength: 2
  #   displayKey: 'title'
  #   source: getSongData
  #   templates: 
  #     suggestion: Mustache.compile("<p>{{title}} - {{artist_name}}</p>")

# Integrate from here 
$(document).ready ->

  $('.add-track').click ->
    event.preventDefault()
    console.log "added track!"

  $('html').on 'click', '.delete-track', (e) ->
    e.preventDefault()
    track = $(this).parent()
    console.log(track)

    $.ajax url: $(this).attr('href'), method: 'delete', success: ->
      track.remove()
      

  $('#new_track').on 'submit', (event) ->
    event.preventDefault()

    duration = secondsToMinutes = (duration) ->
      minutes = Math.floor(duration / 60)
      seconds = (duration - minutes * 60).toFixed()
      minutes: minutes
      seconds: seconds

    artist = $('#track_artist').val()

    $.ajax(
      url: "http://developer.echonest.com/api/v4/song/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=5&artist=" + artist + "&bucket=id:7digital-UK&bucket=tracks&bucket=audio_summary"
      dataType: "jsonp"
    ).success (response) ->
      console.log response
      songs = response.response.songs
      $.each songs, (index, value) ->
        if value.tracks[0] is `undefined`
          value["duration"] = duration(value.audio_summary.duration)
          song_details = Mustache.render($("#song-details-without-preview-template").html(), value)
          $(song_details).appendTo "#song-details"
        else if value.tracks[0] isnt `undefined`
          value["preview_url"] = value.tracks[0].preview_url
          value["release_image"] = value.tracks[0].release_image
          value["duration"] = duration(value.audio_summary.duration)
          song_details = Mustache.render($("#song-details-with-preview-template").html(), value)
          $(song_details).appendTo "#song-details"
        return
      return
    

    # $.post $(this).attr('action'), $(this).serialize(), (track) ->
    #   trackHTML = Mustache.render $('#playlist-template').html(), track
    #   console.log
    #   $('.track-listing').append(trackHTML)
    #   $('#track_song').val("")
    #   $('#track_artist').val("")