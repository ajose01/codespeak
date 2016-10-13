class BotMessage

  attr_accessor :messenger_uid
  attr_accessor :text
  attr_accessor :messenger

  def initialize messenger, data
    @messenger = messenger
    case messenger
    when :facebook
      populate_variables_for_fb data
    end
  end

  private

  def populate_variables_for_fb message
    @messenger_uid = message.sender["id"]
    @text = message.text.strip.downcase
  end

end
