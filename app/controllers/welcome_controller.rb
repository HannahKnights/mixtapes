class WelcomeController < ApplicationController

  def index
    @mixtape = Mixtape.new

    if user_signed_in?
      
      redirect_to edit_user_registration_path
        
      Mixtape.where(user_id: current_user.id).count > 1 ? (puts 'Greedy!!!!!!!!!!!!!!!!') : nil
      
   
    end


  end


end
