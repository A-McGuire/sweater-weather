require 'rails_helper'

RSpec.describe '/book-search', :vcr do
  it 'can get a locations books, and forecast' do

    get '/api/v1/book-search?location=denver,co&quantity=5'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data).to be_a Hash
    expect(data).to have_key(:data)
    expect(data[:data]).to be_a Hash
    expect(data[:data].keys).to eq([:id, :type, :attributes])
    expect(data[:data][:id]).to eq(nil)
    expect(data[:data][:type]).to eq('books')
    expect(data[:data][:attributes].keys).to eq([:destination, :forecast, :total_books_found, :books])
    
    expect(data[:data][:attributes][:destination]).to be_a String

    expect(data[:data][:attributes][:forecast]).to be_a Hash
    expect(data[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
    expect(data[:data][:attributes][:forecast][:summary]).to be_a String
    expect(data[:data][:attributes][:forecast][:temperature]).to be_a String

    expect(data[:data][:attributes][:total_books_found]).to be_a Integer
    expect(data[:data][:attributes][:books]).to be_an Array
    expect(data[:data][:attributes][:books].count).to eq(5)
    expect(data[:data][:attributes][:books].first).to be_a Hash
    expect(data[:data][:attributes][:books].first.keys).to eq([:isbn, :title, :publisher])
    expect(data[:data][:attributes][:books].first[:isbn]).to be_an Array
    expect(data[:data][:attributes][:books].first[:title]).to be_an String
    expect(data[:data][:attributes][:books].first[:publisher]).to be_an String
  end
end