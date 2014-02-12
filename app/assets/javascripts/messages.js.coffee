# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  setTimeout (-> 
    $('.conversation').first().trigger "click"
    ), 10

  $('.conversation').on 'click', ->
    $('.selected-message').removeClass('selected-message')
    $(this).addClass('selected-message')

    $.get "/messages/#{$(this).data("id")}", (messages) ->
      conversation = Mustache.render $("#message-template").html(), messages

      $(".correspondent-message").html(conversation)
      $(".correspondent-message").scrollTop $('.correspondent-message')[0].scrollHeight

  $('body').on 'submit', '.new-message', (event) ->
    event.preventDefault()

    $.post '/messages', $(this).serialize()

  dispatcher = new WebSocketRails(window.location.host + '/websocket')
  channel = dispatcher.subscribe('messages')
  channel.bind 'new', (message) ->
    # console.log('hi')
    myId = $('.correspondent-message').data('my-id')

    if message.author_id != myId
      message.from = 'them'

    message = Mustache.render $("#single-message-template").html(), message

    $(".message-area").append(message)
    $(".correspondent-message").animate(scrollTop: $('.correspondent-message')[0].scrollHeight)

