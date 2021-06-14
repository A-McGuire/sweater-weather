class Api::V1::WeatherController < ApplicationController
  def forecast
    return render status: :bad_request if params[:location].nil? || params[:location] == ''

    forecast = ForecastFacade.location_weather_data(params[:location])
    render json: ForecastSerializer.new(forecast).serializable_hash
  end
end
