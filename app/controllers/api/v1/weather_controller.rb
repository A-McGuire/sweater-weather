class Api::V1::WeatherController < ApplicationController
  def forcast
    return render status: :bad_request if params[:location].nil? || params[:location] == ''
    forcast = ForcastFacade.location_weather_data(params[:location])
    render json: ForcastSerializer.new(forcast).serializable_hash
  end
end
