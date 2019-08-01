class PhotosController < ApplicationController
  before_action :set_photo, only: [:destroy]

  def index
    @photos = Rails.cache.fetch("images", expires_in: 1.hours) do
      Photo.all
    end

    # # @photos = Photo.where(id: photos_ids)

    # @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def destroy
    @photo.destroy
  end

  def create
    if Photo.create(photo_params)
      redirect_to photos_path, notice: "Foto guardada"
    else
      redirect_to :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end