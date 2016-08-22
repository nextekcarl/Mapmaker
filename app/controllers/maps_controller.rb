class MapsController < ApplicationController

  def index
    @maps = Map.all
  end

  def show
    @map = Map.find(params[:id])
  end

  def new
    @map = Map.new
  end

  def create
    if @map = Map.create(map_params)
      redirect_to map_path(@map), :notice => "Map was saved"
    else
      render :new, :error => "Map save failed!"
    end
  end

  private

    def map_params
      params.require(:map).permit(:utf8, :authenticity_token, :name, :description, :svg)
    end
end
