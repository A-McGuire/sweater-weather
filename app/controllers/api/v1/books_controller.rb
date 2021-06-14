class Api::V1::BooksController < ApplicationController
  def index
    # TODO: refactor error handling into helper method. In app controller? 
    return render json: {error: 'location parameter required'}, 
      status: :bad_request if params[:location].nil? || params[:location] == ''
    return render json: {error: 'quantity parameter required'}, 
      status: :bad_request if params[:quantity].nil? || params[:quantity] == ''
    return render json: {error: 'quantity parameter must be an integer greater than 0'}, 
      status: :bad_request if params[:quantity].to_i <= 0
    books = BookFacade.location_book_data(params[:location], params[:quantity])
    render json: BookSerializer.new(books).serializable_hash
  end
end
