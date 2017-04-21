class TracksController < ApplicationController
  before_action :logged_in?

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      redirect_to new_album_track_url
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album = Album.find(@track.album_id)
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = ["Incorrect attributes"]
      redirect_to edit_track_url(@track)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track
      @track.destroy
      redirect_to albums_url(@track.album_id)
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :lyrics)
  end

end
