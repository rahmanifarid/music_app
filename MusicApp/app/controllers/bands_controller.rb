class BandsController < ApplicationController
  before_action :logged_in?

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      flash.now[:errors] = ["Band 404"]
      redirect_to bands_url
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url
    else
      redirect_to new_band_url
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to bands_url
    else
      flash.now[:errors] = ["Incorrect attributes"]
      redirect_to edit_band_url(@band)
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band
      @band.destroy
      redirect_to bands_url
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
