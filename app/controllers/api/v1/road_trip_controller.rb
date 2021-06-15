class Api::V1::RoadTripController < ApplicationController
  def index
    if User.find_by(api_key: params[:api_key]).nil? || params[:api_key].nil?
      return render json: { errors: 'YOU SHALL NOT PASS' },
                    status: :unauthorized
    end

    trip_details = RoadTripFacade.get_trip_details({ origin: params[:origin], destination: params[:destination] })
    render json: RoadTripSerializer.new(trip_details).serializable_hash
  end
end
