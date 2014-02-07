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
    @mixtape = Mixtape.find params[:id]
    # @tracks = @mixtape.tracks
    @track = Track.new
  end

  def update
    @mixtape = Mixtape.find params[:id]
    @mixtape.user = current_user
    @mixtape.update params[:mixtape].permit(:title, :user)
    redirect_to '/mixtapes'
  end

  private

  # def mixtape_must_be_unique
  #   if current_user.mixtape 
  #     flash[:alert] = 'Only one mixtape allowed!'
  #     redirect_to mixtapes_path and return
  #   end
  # end

end
