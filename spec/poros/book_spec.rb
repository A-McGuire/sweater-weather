require 'rails_helper'

RSpec.describe 'book poro', :vcr do
  it 'has readable attributes' do
    location = 'denver, co'
    forecast = ForecastFacade.location_weather_data(location)
    data = OpenLibraryService.get_location_books(location, 5)
    books = {
      destination: location,
      forecast: {
        summary: forecast.current_weather[:conditions],
        temperature: "#{forecast.current_weather[:temperature]} F"
      },
      total_books_found: data[:numFound],
      books: data[:docs].map do |book|
        {
          isbn: book[:isbn],
          title: book[:title],
          publisher: book[:publisher]
        }
      end
    }

    book_obj = Book.new(books)
    
    expect(book_obj.id).to eq(nil)
    expect(book_obj).to be_a Book
    
    expect(book_obj.destination).to be_a String
    expect(book_obj.forecast).to be_a Hash
    expect(book_obj.forecast.keys).to eq([:summary, :temperature])
    expect(book_obj.forecast[:summary]).to be_a String
    expect(book_obj.forecast[:temperature]).to be_a String
    expect(book_obj.total_books_found).to be_an Integer
    expect(book_obj.books).to be_an Array
    expect(book_obj.books.first.keys).to eq([:isbn, :title, :publisher])
    expect(book_obj.books.first[:isbn]).to be_an Array
    expect(book_obj.books.first[:title]).to be_a String
    expect(book_obj.books.first[:publisher]).to be_an Array
  end
end