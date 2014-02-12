class LikesController < ApplicationController

  def create
    Like.where( match_mix_id: params[:mixtape_id],
                 user_mix_id: current_user.mixtape_id,
                 like: params[:like],
                 block: params[:block] ).first_or_create
    render json: { status: 'success' }
  end
end
