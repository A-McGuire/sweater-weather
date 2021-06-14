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
    expect(data[:data][:attributes][:books].first[:title]).to be_a String
    expect(data[:data][:attributes][:books].first[:publisher]).to be_an Array
  end

  describe 'sad path' do
    it 'returns a 400 if there is no location param provided' do
      get '/api/v1/book-search?quantity=5'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("location parameter required")
    end

    it 'returns a 400 if the location param is empty' do
      get '/api/v1/book-search?location=&quantity=5'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("location parameter required")
    end

    it 'returns a 400 if the quantity param is empty' do
      get '/api/v1/book-search?location=denver,co&quantity='

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("quantity parameter required")
    end

    it 'returns a 400 if the quantity param is missing' do
      get '/api/v1/book-search?location=denver,co'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("quantity parameter required")
    end

    it 'returns a 400 if the quantity param is not an interger' do
      get '/api/v1/book-search?location=denver,co&quantity=x'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("quantity parameter must be an integer greater than 0")
    end

    it 'returns a 400 if the quantity param is not an interger greater than 0' do
      get '/api/v1/book-search?location=denver,co&quantity=0'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("quantity parameter must be an integer greater than 0")
    end

    it 'returns a 400 if the quantity param is not an interger greater than 0' do
      get '/api/v1/book-search?location=denver,co&quantity=-10'

      data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(data.keys).to eq([:error])
      expect(data[:error]).to eq("quantity parameter must be an integer greater than 0")
    end
  end
end