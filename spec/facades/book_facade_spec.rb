require 'rails_helper'

RSpec.describe 'book facade', :vcr do
  it 'creates an object with the correct attributes' do
    books = BookFacade.location_book_data('denver, co', 5)

    expect(books.id).to eq(nil)
    expect(books.data).to be_a Hash
    expect(books.data.keys.count).to eq(4)
    expect(books.data.keys)
    .to eq([
      :destination, :forcast, :total_books_found, :books
      ])
    
    expect(books.data[:destination]).to be_a String
    expect(books.data[:forcast]).to be_a Hash
    expect(books.data[:forcast].keys).to eq([:summary, :temperature])
    expect(books.data[:forcast][:summary]).to be_a String
    expect(books.data[:forcast][:temperature]).to be_a String

    expect(books.data[:total_books_found]).to be_a Integer
    expect(books.data[:books]).to be_an Array
    expect(books.data[:books].first.keys).to eq([:isbn, :title, :publisher])
    expect(books.data[:books].first[:isbn]).to be_an Array
    expect(books.data[:books].first[:title]).to be_a String
    expect(books.data[:books].first[:publisher]).to be_an Array
  end
end