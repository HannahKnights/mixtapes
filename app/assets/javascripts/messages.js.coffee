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
    $('#message-body').each ->
      @reset()
      return

  $('.conversation').tsort('.message-time', {data: 'timestamp', order: 'desc'})
  

  dispatcher = new WebSocketRails(window.location.host + '/websocket')
  channel = dispatcher.subscribe('messages')
  channel.bind 'new', (message) ->
    
    myId = $('#user-id').data('my-id')
    theirId = $('.message-area').data('user-id')

    return unless message.recipient_id == myId || message.author_id == myId

    if $('.message-area').length
      return unless message.recipient_id == theirId || message.author_id == theirId

      if message.author_id != myId
        message.from = 'them'

      messageHTML = Mustache.render $("#single-message-template").html(), message

      $(".message-area").append(messageHTML)
      $(".correspondent-message").animate(scrollTop: $('.correspondent-message')[0].scrollHeight)

      $('.selected-message').find('.message-time').text(message.short_created_at).data('timestamp', message.timestamp)

      $('.conversation').tsort('.message-time', {data: 'timestamp', order: 'desc'})
    
    else
      $('.notification').addClass('badge')














