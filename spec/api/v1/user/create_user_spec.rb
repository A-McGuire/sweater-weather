require 'rails_helper'

RSpec.describe 'POST /users' do
  it 'recieves user data as json in body and creates user' do
    body = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post '/api/v1/users', params: body.to_json, headers: { "Content-Type": "application/json" }

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

  it 'responds with a 400 level status with description why in body if failed'
end