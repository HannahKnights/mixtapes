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

  def match_rate(me, you)
    me_song, me_artist, me_genre = mix_values(me, 'id') , mix_values(me, 'artist'), mix_values(me, 'genre')
    you_song, you_artist, you_genre = mix_values(you, 'id') , mix_values(you, 'artist'), mix_values(you, 'genre')
    result = (((me_genre & you_genre).count * 2) + 
              ((me_song & you_song).count * 3) + 
              ((me_artist & you_artist).count * 1))
  end

  def mix_values(mixtape, attribute) 
    mixtape.map{ |song| song[attribute.to_sym] }
  end


  

  # def mixtape_must_be_unique
  #   if current_user
  #     current_user.mixtape 
  #     flash[:alert] = 'Only one mixtape allowed!'
  #     redirect_to mixtapes_path and return
  #   end
  # end

  helper_method :match_rate

end
