class Message < ApplicationRecord
  belongs_to :user
  after_create :broadcast_message

  def broadcast_message
    broadcast_append_to "messages"
  end
end
