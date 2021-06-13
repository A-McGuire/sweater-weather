require 'rails_helper'

RSpec.describe '/backgrounds', :vcr do
  it 'can get a locations image' do

    get '/api/v1/forcast?location=denver, co'

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
    expect(image[:data][:attributes][:image].keys).to eq([:location, :image_url, :credit])
    expect(image[:data][:attributes][:location]).to be_a String
    expect(image[:data][:attributes][:image_url]).to be_a String
    expect(image[:data][:attributes][:credit]).to be_a String
    expect(image[:data][:attributes][:image]).to be_a Hash
    expect(image[:data][:attributes][:image][:credit].keys).to eq([:source, :author, :logo])
    expect(image[:data][:attributes][:image][:credit][:source]).to be_a String
    expect(image[:data][:attributes][:image][:credit][:author]).to be_a String
    expect(image[:data][:attributes][:image][:credit][:logo]).to be_a String
  end
end