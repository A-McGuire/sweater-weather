require 'rails_helper'

RSpec.describe 'POST /users', :vcr do
  it 'recieves user data as json in body and creates user' do
    body = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }

    user = User.find_by(email: 'whatever@example.com')
    
    expect(response).to be_successful
    expect(response.status).to eq(201)

    resp = JSON.parse(response.body, symbolize_names: true)
    
    expect(resp.keys).to eq([:data])
    expect(resp[:data]).to be_a Hash
    expect(resp[:data].keys).to eq([:id, :type, :attributes])
    expect(resp[:data][:type]).to eq('users')
    expect(resp[:data][:id]).to eq(user.id.to_s)
    expect(resp[:data][:attributes]).to be_a Hash
    expect(resp[:data][:attributes].keys).to eq([:email, :auth_token])
    expect(resp[:data][:attributes][:email]).to eq(user.email)
    expect(resp[:data][:attributes][:auth_token]).to eq(user.auth_token)

    expect(user.class).to eq(User)
    expect(user.email).to eq('whatever@example.com')
  end

  describe 'sad path' do
    it 'responds with a 409 level status if email is taken' do
      user = User.create!(email: 'whatever@example.com', password: '123', password_confirmation: '123')
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(409)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Email has already been taken')
    end
  
    it 'responds with a 400 level status if email is blank' do
      body = {
        email: "",
        password: "123",
        password_confirmation: "123"
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq("Email is required")
    end
  
    it 'responds with a 400 level status if email is missing' do
      body = {
        password: "123",
        password_confirmation: "123"
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq("Email is required")
    end
  
    it 'responds with a 400 level status if passwords do not match' do
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "pass"
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq("Passwords do not match")
    end
  
    it 'responds with a 400 level status if password is blank' do
      body = {
        email: "whatever@example.com",
        password: "",
        password_confirmation: ""
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq("Password is required")
    end

    it 'responds with a 400 level status if password is missing' do
      body = {
        email: "whatever@example.com"
      }
  
      post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq("Password is required")
    end
  end
end