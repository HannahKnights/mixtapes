class MixtapesController < ApplicationController

  # before_action :authenticate_user!
  # before_action :mixtape_must_be_unique, only: [:new, :create]

  def new
    if user_signed_in?
      user = current_user
      if Mixtape.where( user_id: user.id ).count > 1
        flash[:alert] = 'Ooops! Only one mixtape allowed!'
        @mixtape = user.mixtape
        session[:mixtape_id] = @mixtape.id
        Mixtape.where(user_id: user.id).last.destroy
      else
        @mixtape = user.mixtape
        session[:mixtape_id] = @mixtape.id
      end
    else
      if session[:mixtape_id]
        @mixtape = Mixtape.find session[:mixtape_id]
      else
        @mixtape = Mixtape.create        
        session[:mixtape_id] = @mixtape.id      
      end      
    end
    title = params[:mixtape][:title] if params[:mixtape]
    @mixtape.title = title if title
    @tracks = @mixtape.tracks
    @track = Track.new
  end

  def create
    @mixtape = Mixtape.new params[:mixtape].permit(:title)
    @mixtape.user = current_user

    if @mixtape.save
      redirect_to mixtapes_path
    else
      render 'new'
    end
  end
  
  def show
    @mixtape = Mixtape.find params[:id]
  end

  def delete_track
    mixtape = Mixtape.find params[:id]
    track = mixtape.tracks.find params[:track_id]
    render 'new'
  end

  def index
    if current_user.mixtape.tracks.empty?
      flash[:error] = "Please make a mixtape!!"
      redirect_to new_mixtape_path
    else
      @mixtapes = Mixtape.all 
    end
  end

  def edit
    redirect_to new_mixtape_path
  end

  def update
    @mixtape = Mixtape.find session[:mixtape_id]
    @mixtape.update params[:mixtape].permit(:title)
    render json: { status: 'success' }
  end

  # def mixtape_must_be_unique
  #   if current_user
  #     current_user.mixtape 
  #     flash[:alert] = 'Only one mixtape allowed!'
  #     redirect_to mixtapes_path and return
  #   end
  # end

end
