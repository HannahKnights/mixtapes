class PhotosController < ApplicationController


  def update
    user_photos = Photo.where(user_id: current_user.id)
    photo = current_user.photos.find_by image_url: params[:image_url]
    if user_photos.where(profile_picture: true).count < 5 && photo.profile_picture != true 
      photo.update_attributes( profile_picture: true )
    else
      flash[:error] = "Sorry we cannot save that picture!"
    end
    render json: { status: 'success' }
  end

  def destroy
    user_photos = Photo.where(user_id: current_user.id)
    photo = Photo.find(params[:id])
    if user_photos.where(profile_picture: true).count > 1
      photo.update_attributes( profile_picture: false )
    else
      flash[:error] = "Sorry you must have more than one picture!"
    end
    render json: { status: 'success' }
  end

end
