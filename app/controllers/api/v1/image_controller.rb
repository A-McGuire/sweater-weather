class Api::V1::ImageController < ApplicationController
  def background
    return render status: :bad_request if params[:location].nil? || params[:location] == ''

    backgrounds = ImageFacade.location_image_data(params[:location])
    render json: ImageSerializer.new(backgrounds).serializable_hash
  end
end
