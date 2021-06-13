require 'rails_helper'

RSpec.describe 'image facade', :vcr do
  it 'creates an object with the correct attributes' do
    data = ImageFacade.location_image_data('denver, co')

    expect(data.id).to eq(nil)
    
    expect(data.image).to be_a Hash
    expect(data.image.keys.count).to eq(6)
    expect(data.image.keys)
    .to eq([
      :location, :image_url_full, :image_url_regular, 
      :image_url_small, :image_url_thumb, :credit
      ])
    
    expect(data.image[:location]).to be_a String
    expect(data.image[:image_url_full]).to be_a String
    expect(data.image[:image_url_regular]).to be_a String
    expect(data.image[:image_url_small]).to be_a String
    expect(data.image[:image_url_thumb]).to be_a String
    expect(data.image[:credit]).to be_a Hash
    expect(data.image[:credit][:source]).to be_a String
    expect(data.image[:credit][:author]).to be_a String
    expect(data.image[:credit][:author_profile]).to be_a String
  end
end