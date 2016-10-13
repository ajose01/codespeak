module Platform
  class Fb
    include Facebook::Messenger

    def self.on_receive_message bot_message
      case bot_message.text
      when "tacos"
        reply = "OMG WE LOOOOOVE TACOS!!!! 🌮🌮🌮🌮"
        buttons = ["Hi", "Pirate"]
        keyboard = keyboard_for_buttons buttons
      when "pirate"
        query = {"text" => "Hey LA Ruby! You are the most awesome people in the world"}
        response = HTTParty.get("http://isithackday.com/arrpi.php", query: query)
        reply = response.parsed_response
        buttons = ["Tacos", "Hi"]
        keyboard = keyboard_for_buttons buttons
      else
        reply = "Hey LA Ruby! Let's learn more about chat bots!"
        buttons = ["Tacos", "Pirate"]
        keyboard = keyboard_for_buttons buttons
      end
      send_message bot_message.messenger_uid, reply, keyboard
    end

    def self.send_message id, text, keyboard=[]
      Bot.deliver(
        recipient: { id: id },
        message: {
          text: text,
          quick_replies: keyboard
        }
      )
    end

    def self.keyboard_for_buttons options=[]
      keyboard = []
      options.each do |key|
        reply = {
          content_type: "text",
          title: key,
          payload: key
        }
        keyboard << reply
      end
      keyboard
    end

  end
end
