require 'rails_helper'

RSpec.describe '/backgrounds', :vcr do
  it 'can get a locations image' do

    get '/api/v1/backgrounds?location=denver, co', headers: { "Content-Type": "application/json", "Accept": "application/json" }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    image = JSON.parse(response.body, symbolize_names: true)
    
    expect(image).to be_a Hash
    expect(image).to have_key(:data)
    expect(image[:data]).to be_a Hash
    expect(image[:data].keys).to eq([:id, :type, :attributes])
    expect(image[:data][:id]).to eq(nil)
    expect(image[:data][:type]).to eq('image')
    expect(image[:data][:attributes].keys).to eq([:image])
    expect(image[:data][:attributes][:image]).to be_a Hash
    expect(image[:data][:attributes][:image].keys).to eq([:location, :image_url_full, :image_url_regular, :image_url_small, :image_url_thumb, :credit])
    expect(image[:data][:attributes][:image][:location]).to be_a String
    expect(image[:data][:attributes][:image][:image_url_full]).to be_a String
    expect(image[:data][:attributes][:image][:image_url_regular]).to be_a String
    expect(image[:data][:attributes][:image][:image_url_small]).to be_a String
    expect(image[:data][:attributes][:image][:image_url_thumb]).to be_a String
    expect(image[:data][:attributes][:image][:credit]).to be_a Hash
    expect(image[:data][:attributes][:image][:credit].keys).to eq([:source, :author, :author_profile])
    expect(image[:data][:attributes][:image][:credit][:source]).to be_a String
    expect(image[:data][:attributes][:image][:credit][:author]).to be_a String
    expect(image[:data][:attributes][:image][:credit][:author_profile]).to be_a String
  end

    describe 'sad path' do
    it 'returns a 400 if there is no location param provided' do
      get '/api/v1/backgrounds', headers: { "Content-Type": "application/json", "Accept": "application/json" }

      expect(response.status).to eq(400)
    end

    it 'returns a 400 if the location param is empty' do
      get '/api/v1/backgrounds?location=', headers: { "Content-Type": "application/json", "Accept": "application/json" }

      expect(response.status).to eq(400)
    end
  end
end