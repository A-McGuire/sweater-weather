require 'rails_helper'

RSpec.describe 'book facade', :vcr do
  it 'creates an object with the correct attributes' do
    books = BookFacade.location_book_data('denver, co', 5)
    
    expect(books.id).to eq(nil)
    expect(books).to be_a Book
    
    expect(books.destination).to be_a String
    expect(books.forecast).to be_a Hash
    expect(books.forecast.keys).to eq([:summary, :temperature])
    expect(books.forecast[:summary]).to be_a String
    expect(books.forecast[:temperature]).to be_a String
    expect(books.total_books_found).to be_an Integer
    expect(books.books).to be_an Array
    expect(books.books.first.keys).to eq([:isbn, :title, :publisher])
    expect(books.books.first[:isbn]).to be_an Array
    expect(books.books.first[:title]).to be_a String
    expect(books.books.first[:publisher]).to be_an Array

    # TODO: revert test to old format once openstruct and serializer decide to play nice
    #commented out to use later with openstruct
    # expect(books.id).to eq(nil)
    # expect(books.data).to be_a Hash
    # expect(books.data.keys.count).to eq(4)
    # expect(books.data.keys)
    # .to eq([
    #   :destination, :forecast, :total_books_found, :books
    #   ])
    
    # expect(books.data[:destination]).to be_a String
    # expect(books.data[:forecast]).to be_a Hash
    # expect(books.data[:forecast].keys).to eq([:summary, :temperature])
    # expect(books.data[:forecast][:summary]).to be_a String
    # expect(books.data[:forecast][:temperature]).to be_a String
    
    # expect(books.data[:total_books_found]).to be_a Integer
    # expect(books.data[:books]).to be_an Array
    # expect(books.data[:books].first.keys).to eq([:isbn, :title, :publisher])
    # expect(books.data[:books].first[:isbn]).to be_an Array
    # expect(books.data[:books].first[:title]).to be_a String
    # expect(books.data[:books].first[:publisher]).to be_an Array
  end
end