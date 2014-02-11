$(document).ready ->
  Mustache.compile = (template) ->
    Mustache.parse(template);

    return (view, partials) ->
      Mustache.render(template, view, partials)

  getArtistData = (query, callback) ->
    $.ajax(
      url: "http://developer.echonest.com/api/v4/artist/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=5&name=" + query
      dataType: "jsonp"
    ).done (response) ->
      artists = response.response.artists
      names = $.map artists, (artist) ->
        {name: artist.name}
      callback(names)
  $('#track_artist').typeahead null,
    name: "artists"
    minLength: 2
    displayKey: 'name'
    source: getArtistData

  $('#find-songs').click ->

    console.log 'Finding songs...'

    duration = secondsToMinutes = (duration) ->
      minutes = Math.floor(duration / 60)
      seconds = (duration - minutes * 60).toFixed()
      minutes: minutes,
      seconds: seconds

    $.ajax(
      url: "http://developer.echonest.com/api/v4/song/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=50&artist=" + $("#track_artist").val() + "&bucket=id:7digital-UK&bucket=tracks&song_type=studio:true&bucket=audio_summary&sort=song_hotttnesss-desc",
      dataType: "jsonp"
    ).done (response) ->
      console.log 'Songs found!'
      console.log response
      songs = response.response.songs
      $.each songs, (index, value) ->
        if value.tracks[0] is `undefined`
          # value.duration = duration(value.audio_summary.duration)
          # songDetailsWithoutPreview = Mustache.render($("#song-details-without-preview-template").html(), value)
          # $(songDetailsWithoutPreview).appendTo "#song-details"
        else if value.tracks[0] isnt `undefined`
          value.preview_url = value.tracks[0].preview_url
          value.release_image = value.tracks[0].release_image
          value.duration = duration(value.audio_summary.duration)
          songDetailsWithPreview = Mustache.render($("#song-details-with-preview-template").html(), value)
          $(songDetailsWithPreview).appendTo "#song-details"
        return
      return

  $('html').on 'click', '.delete-track', (e) ->
    e.preventDefault()
    track = $(this).parent()
    console.log 'Deleting track...'
    console.log(track)

    $.ajax(
      type: 'DELETE',
      url: $(this).attr('href')
    ).done (response) ->
      console.log 'Track deleted!'
      track.remove()

  $('html').on 'click', '.add-track', (e) ->
    e.preventDefault()
    console.log 'Adding track to mixtape...'

    trackHash = {}
    trackHash.artist = $(this).parent().children('.artist-name').text()
    trackHash.song = $(this).parent().children('.track-title').text()
    trackHash.mixtape_id = $('.fb-auth').data('mixtape-id')
    # trackHash.echonest_id = 

    $.ajax(
      type: 'POST',
      url: document.location.origin + $('#new_track').attr('action'),
      data: { 
        track: {
          artist: trackHash.artist,
          song: trackHash.song
          mixtape_id: $('.fb-auth').data('mixtape-id')
        }
      }
    ).done (response) ->
      trackHash.id = response.id
      console.log 'Track added to mixtape!'
      console.log trackHash
      trackDetails = Mustache.render $('#playlist-template').html(), trackHash
      $(trackDetails).appendTo ".track-listing"

  $('#new_track').on 'submit', (event) ->
    event.preventDefault()
    
  #   $.post $(this).attr('action'), $(this).serialize(), (track) ->
  #     trackHTML = Mustache.render $('#playlist-template').html(), track
  #     console.log
  #     $('.track-listing').append(trackHTML)
  #     $('#track_song').val("")
  #     $('#track_artist').val("")