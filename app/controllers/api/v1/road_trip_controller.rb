class Api::V1::RoadTripController < ApplicationController
  def index
    trip_details = RoadTripFacade.get_trip_details({origin: params[:origin], destination: params[:destination]})
    render json: RoadTripSerializer.new(trip_details).serializable_hash
  end
end