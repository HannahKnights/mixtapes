class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.create message_params

    if @message.save
      flash[:notice] = "Your message has been sent"
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def index
    @received_messages = current_user.received_messages
    @sent_messages = current_user.sent_messages
  end 

  def show
    redirect_to new_message_path
  end


  private

    def message_params
      { author: current_user,
        recipient: User.find_by_name(params[:message][:recipient]), 
        body: params[:message][:body],
        subject: params[:message][:subject]
      }
    end

end