class MixtapesController < ApplicationController

  def new
    @mixtape = Mixtape.new
  end

  def create
    @mixtape = Mixtape.new params[:mixtape].permit(:title)
    if @mixtape.save
      redirect_to mixtape_path(@mixtape)
    else
      render 'new'
     
    end
  end
  
  def show
    @mixtape = Mixtape.find params[:id]
  end

end
