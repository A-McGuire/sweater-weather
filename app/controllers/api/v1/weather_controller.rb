class Api::V1::WeatherController < ApplicationController
  def forecast
    return render status: 400 if params[:location].nil? || params[:location] == ''
    forecast = ForecastFacade.location_weather_data(params[:location])
    render json: ForecastSerializer.new(forecast).serializable_hash
  end
end
