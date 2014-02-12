  json.body @message.body
  json.created_at @message.created_at.strftime('%-d %b %Y - %l:%M %P')
  json.from 'me'