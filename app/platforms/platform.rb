module Platform
  class Fb
    include Facebook::Messenger

    def self.on_receive_message bot_message
      case bot_message.text
      when "tacos"
        reply = "OMG WE LOOOOOVE TACOS!!!! 🌮🌮🌮🌮"
      when "pirate"
        query = {"text" => "Hey LA Ruby! You are the most awesome people in the world"}
        response = HTTParty.get("http://isithackday.com/arrpi.php", query: query)
        reply = response.parsed_response
      else
        reply = "Hey LA Ruby! Let's learn more about chat bots!"
      end
      send_message bot_message.messenger_uid, reply
    end

    def self.send_message id, text
      Bot.deliver(
        recipient: { id: id },
        message: {
          text: text
        }
      )
    end

  end
end
