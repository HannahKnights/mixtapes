class PhotosController < ApplicationController

  def create
    user = current_user
    @photo = user.photos.create 
    @photo.image_url = params[:image_url]
    @photo.save

    redirect_to ('/users/edit')
  end

  def destroy
    @photo = Photo.find_by id: params[:id]
    @photo.destroy
    render json: { status: 'success' }
  end

end
