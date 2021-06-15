class Api::V1::RoadTripController < ApplicationController
  def index
    return render status: :unauthorized if User.find_by(api_key: params[:api_key]).nil? || params[:api_key].nil?
    
    trip_details = RoadTripFacade.get_trip_details({ origin: params[:origin], destination: params[:destination] })
    render json: RoadTripSerializer.new(trip_details).serializable_hash
  end
end
