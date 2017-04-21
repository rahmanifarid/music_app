class AlbumsController < ApplicationController
  before_action :logged_in?


  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      redirect_to new_band_album_url
    end
  end

  def edit
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to bands_url
    else
      flash.now[:errors] = ["Incorrect attributes"]
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album
      @album.destroy
      redirect_to bands_url
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :name, :style)
  end

end
