require 'rails_helper'

RSpec.describe 'open library service', :vcr do
  it 'returns data in the correct format' do
    location = 'denver, co'
    quantity = 5
    data = OpenLibraryService.get_location_books(location, quantity)
    
    expect(data).to be_a Hash
    expect(data.keys).to eq([:numFound, :start, :numFoundExact, :docs, :num_found])
    expect(data[:numFound]).to be_an Integer
    expect(data[:start]).to be_an Integer
    expect(data[:docs]).to be_an Array
    expect(data[:docs].first.keys.include?(:title)).to eq(true)
    expect(data[:docs].first.keys.include?(:isbn)).to eq(true)
    expect(data[:docs].first.keys.include?(:publisher)).to eq(true)
  end
end