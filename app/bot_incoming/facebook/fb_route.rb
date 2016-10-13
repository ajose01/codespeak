include Facebook::Messenger
# Sample 1
# Bot.on :message do |message|
#   puts message.inspect
#   puts message.text
#   puts message.sender
#   Bot.deliver(
#     recipient: message.sender,
#     message: {
#       text: "Hello LA Ruby!\nWhat would you like me to do?"
#     }
#   )
# end


# Sample 2
Bot.on :message do |message|
  incoming_message = message.text.strip.downcase
  case incoming_message
  when "tacos"
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "OMG WE LOOOOOVE TACOS!!!! 🌮🌮🌮🌮"
      }
    )
  when "pirate"
    query = {"text" => "Hey LA Ruby! You are the most awesome people in the world"}
    response = HTTParty.get("http://isithackday.com/arrpi.php", query: query)
    message_text = response.parsed_response
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: message_text
      }
    )
  else
    Bot.deliver(
      recipient: message.sender,
      message: {
        text: "Hello LA Ruby!\nWhat would you like me to do?"
      }
    )
  end
end
