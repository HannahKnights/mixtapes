class TracksController < ApplicationController

  respond_to :html, :js

  def new
    @tracks = Track.new
    @mixtape = Mixtape.find(params[:mixtape_id])
  end

  def create
  end



end
