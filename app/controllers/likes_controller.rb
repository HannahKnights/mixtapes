class LikesController < ApplicationController

  def create

    Like.create( match_mix_id: params[:mixtape_id],
                 user_mix_id: current_user.mixtape_id,
                 like: true )

    render json: { status: 'success' }

  end


end
