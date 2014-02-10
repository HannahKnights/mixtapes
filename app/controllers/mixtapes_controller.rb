class MixtapesController < ApplicationController

  # before_action :authenticate_user!
  # before_action :mixtape_must_be_unique, only: [:new, :create]

  def new
    if session[:mixtape_id]
      @mixtape = Mixtape.find session[:mixtape_id]
    else
      @mixtape = Mixtape.create
      session[:mixtape_id] = @mixtape.id
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
    @mixtapes = Mixtape.all 
  end

  def edit
    redirect_to new_mixtape_path
  end

  def update
    @mixtape = Mixtape.find session[:mixtape_id]
    @mixtape.update params[:mixtape].permit(:title)

    render json: { status: 'success' }
  end

  private

  # def mixtape_must_be_unique
  #   if current_user.mixtape 
  #     flash[:alert] = 'Only one mixtape allowed!'
  #     redirect_to mixtapes_path and return
  #   end
  # end

end
