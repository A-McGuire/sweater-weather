class Api::V1::BooksController < ApplicationController
  def index
    # return render status: 400 if params[:location].nil? || params[:location] == ''
    books = BookFacade.location_book_data('denver, co', 5)
    binding.pry
    render json: BookSerializer.new(books).serializable_hash
  end
end
