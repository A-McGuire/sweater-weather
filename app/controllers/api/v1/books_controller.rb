class Api::V1::BooksController < ApplicationController
  def index
    if params[:location].nil? || params[:location] == ''
      return render json: { error: 'location parameter required' },
                    status: :bad_request
    end
    if params[:quantity].nil? || params[:quantity] == ''
      return render json: { error: 'quantity parameter required' },
                    status: :bad_request
    end
    if params[:quantity].to_i <= 0
      return render json: { error: 'quantity parameter must be an integer greater than 0' },
                    status: :bad_request
    end
    books = BookFacade.location_book_data(params[:location], params[:quantity])
    render json: BookSerializer.new(books).serializable_hash
  end
end
