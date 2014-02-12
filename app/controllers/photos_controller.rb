class PhotosController < ApplicationController


  def update
    user_photos = Photo.where(user_id: current_user.id)
    photo = current_user.photos.find_by image_url: params[:image_url]
    if user_photos.where(profile_picture: true).count < 5 && photo.profile_picture != true 
      photo.update_attributes( profile_picture: true ) 
      render json: { status: 'success', id: photo.id }
    else
      render json: { status: 'Error', message: "Sorry you can't have more than five profile pictures!" }, status: 401
    end
  end

  def destroy
    user_photos = Photo.where(user_id: current_user.id)
    photo = Photo.find(params[:id])
    if user_photos.where(profile_picture: true).count > 1
      photo.update_attributes( profile_picture: false )
      render json: { status: 'success' }
    else
      render json: { status: 'Error', message: "Sorry you must have more than one picture!" }, status: 401
    end
  end

end
