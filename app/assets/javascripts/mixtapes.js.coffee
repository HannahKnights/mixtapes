# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  Mustache.compile = (template) ->
    Mustache.parse(template);

    return (view, partials) ->
      Mustache.render(template, view, partials)

  getArtistData = (query, callback) ->
    $.ajax(
      url: "http://developer.echonest.com/api/v4/artist/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=5&name=" + query
      dataType: "jsonp"
    ).success (response) ->
      artists = response.response.artists
      names = $.map artists, (artist) ->
        {name: artist.name}
      callback(names)
  $('#track_artist').typeahead null,
    name: "artists"
    minLength: 2
    displayKey: 'name'
    source: getArtistData
  getSongData = (query, callback) ->
    $.ajax(
      url: "http://developer.echonest.com/api/v4/song/search?api_key=HY9AC0F4FNZ59GYBO&format=jsonp&results=50&title=" + query
      dataType: "jsonp"
    ).success (response) ->
      console.log(response)
      songs = response.response.songs
      names = $.map songs, (song) ->
        datum = { artist_name: song.artist_name, title: song.title }
      callback(names)
  $('#track_song').typeahead null,
    name: "songs"
    minLength: 2
    displayKey: 'title'
    source: getSongData
    templates: 
      suggestion: Mustache.compile("<p>{{title}} - {{artist_name}}</p>")