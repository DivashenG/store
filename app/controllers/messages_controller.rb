class MessagesController < ApplicationController

  # GET /messages or /messages.json
  def index
    @messages = Message.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  # POST /messages or /messages.json
  def create
    @message = Message.create(message_params)
    @message.user = Current.user

    if @message.save
      # Turbo Streams will handle the broadcast automatically
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
