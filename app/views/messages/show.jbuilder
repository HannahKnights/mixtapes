json.notme_id @notme.id
json.messages @conversation do |message|
  json.body message.body
  json.created_at message.created_at.strftime('%-d %b %Y - %l:%M %P')
  json.from (message.author == current_user ? 'me' : 'them')
end