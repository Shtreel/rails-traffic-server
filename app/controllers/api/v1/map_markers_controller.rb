class Api::V1::MapMarkersController < ApplicationController
  def index
    render json: MapMarker.all, status: :ok
  end

  def create
    map_marker = MapMarker.new(map_marker_params)

    if map_marker.save
      render json: map_marker, status: :ok
    else
      render json: map_marker.errors, status: :unprocessable_entity
    end
  end

  def map_marker_params
    params.require(:map_marker).permit(:longitude, :latitude, :icon_type, :name)
  end
end
