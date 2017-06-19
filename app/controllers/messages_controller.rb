class MessagesController < ApiController
  before_action :set_message_thread, only: [:create]

  def create
    message = current_user.messages.build(message_params)
    message.message_thread_id = @message_thread.id

    if message.save
      # TODO:  use websocket to broadcast
      render json: message, status: :ok
    else
      # Handle error case
    end
  end

  private

  def set_message_thread
    @message_thread = current_user.message_threads.find(params[:message_thread_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
