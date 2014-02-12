class MessagesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create
  # helper_method :current_user

  # def current_user
  #   User.find 1
  # end

  def new
    @send_to = User.find(params[:send_to])
    @message = Message.new
  end

  def create
    @message = Message.create message_params
    WebsocketRails[:messages].trigger 'new', @message.as_json
    if !request.xhr?
      flash[:notice] = "Your message was sent" 
      redirect_to '/mixtapes'
    end
    # if @message.save
    #   # flash[:notice] = "Your message has been sent"
    #   # redirect_to messages_path
    # else
    #   render 'new'
    # end
  end

  def index
    @correspondents = current_user.chatees
    @messages = Message.find_by(author_id: current_user.id )
  end 


  def show
    @message = Message.find params[:id]
    raise unless @message.recipient == current_user || @message.author == current_user

    @notme = [@message.recipient, @message.author].find { |u| u != current_user }

    @conversation = @message.recipient.messages_with(@message.author)
  end

  def destroy
      @message = Message.find params[:id]
      raise unless @message.recipient == current_user || @message.author == current_user

      @conversation = @message.recipient.messages_with(@message.author)
      @conversation.each(&:destroy)
      redirect_to messages_path
  end

  private

    def message_params
      { author: current_user,
        recipient: User.find(params[:recipient_id]), 
        body: params[:body]
      }
    end

end