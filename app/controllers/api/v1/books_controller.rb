class Api::V1::BooksController < ApplicationController
  def index
    return render json: {error: 'location parameter required'}, status: :bad_request if params[:location].nil? || params[:location] == ''
    books = BookFacade.location_book_data(params[:location], params[:quantity])
    render json: BookSerializer.new(books).serializable_hash
  end
end
