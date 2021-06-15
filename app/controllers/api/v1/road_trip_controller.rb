class Api::V1::RoadTripController < ApplicationController
  def index
    return render status: 401 if User.find_by(auth_token: params[:auth_token]).nil? || params[:auth_token].nil?
    trip_details = RoadTripFacade.get_trip_details({origin: params[:origin], destination: params[:destination]})
    render json: RoadTripSerializer.new(trip_details).serializable_hash
  end
end