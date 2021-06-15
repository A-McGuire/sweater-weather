require 'rails_helper'

RSpec.describe 'road trip facade' do
  describe 'get_trip_details', :vcr do 
    it 'creates an object with the correct attributes' do
      params = { origin: "Denver, CO", destination: "Estes Park, CO" }
      data = RoadTripFacade.get_trip_details(params)
      
      expect(data.id).to eq(nil)
      expect(data.start_city).to be_a String
      expect(data.end_city).to be_a String
      expect(data.travel_time).to be_a String
      expect(data.weather_at_eta).to be_a Hash
      expect(data.weather_at_eta.keys).to eq([:temperature, :conditions])
    end

    it 'if the route is not possible it returns impossible for travel time and blank weather block' do
      params = { origin: "Denver, CO", destination: "London, UK" }
      data = RoadTripFacade.get_trip_details(params)
      
      expect(data.id).to eq(nil)
      expect(data.start_city).to be_a String
      expect(data.end_city).to be_a String
      expect(data.travel_time).to eq('Impossible route')
      expect(data.weather_at_eta).to be_a Hash
      expect(data.weather_at_eta.keys).to eq([])
    end
  end

  describe 'travel_time_to_nearest_hour helper method' do
    it 'recieves seconds and returns an integer rounded to the nearest hour' do
      expect(RoadTripFacade.travel_time_to_nearest_hour(3600)).to eq(1)
      expect(RoadTripFacade.travel_time_to_nearest_hour(3000)).to eq(1)
      expect(RoadTripFacade.travel_time_to_nearest_hour(7000)).to eq(2)
      expect(RoadTripFacade.travel_time_to_nearest_hour(7400)).to eq(2)
      expect(RoadTripFacade.travel_time_to_nearest_hour(172800)).to eq(48)
    end
  end
end