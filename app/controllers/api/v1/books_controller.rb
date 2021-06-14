class Api::V1::BooksController < ApplicationController
  def index
    return render status: 400 if params[:location].nil? || params[:location] == ''
    books = OpenLibraryService.get_location_books('denver, co', 5)
    binding.pry
    # render json: ImageSerializer.new(backgrounds).serializable_hash
  end
end
