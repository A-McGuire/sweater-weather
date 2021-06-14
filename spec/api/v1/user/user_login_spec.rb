RSpec.describe 'POST /sessions', :vcr do
  it 'recieves user data as json in body and logs user in' do
    user = User.create!(email: "whatever@example.com", password: "password")

    body = {
      email: "whatever@example.com",
      password: "password"
    }

    post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }

    expect(response).to be_successful
    expect(response.status).to eq(200)

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
  end

  describe 'sad path' do
    it 'responds with a 400 level status if email is incorrect' do
      user = User.create!(email: 'whatever@example.com', password: 'password')
      body = {
        email: "what@example.com",
        password: "password",
      }
  
      post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Invalid user credentials')
    end

    it 'responds with a 400 level status if email field is missing' do
      user = User.create!(email: 'whatever@example.com', password: 'password')
      body = {
        password: "password"
      }
  
      post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Email is required')
    end

    it 'responds with a 400 level status if email is blank' do
      user = User.create!(email: 'whatever@example.com', password: 'password')
      body = {
        email: "",
        password: "password"
      }
  
      post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Invalid user credentials')
    end

    it 'responds with a 400 level status if password is incorrect' do
      user = User.create!(email: 'whatever@example.com', password: 'password')
      body = {
        email: "whatever@example.com",
        password: "pass"
      }
  
      post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Invalid user credentials')
    end

    it 'responds with a 400 level status if password is blank' do
      user = User.create!(email: 'whatever@example.com', password: 'password')
      body = {
        email: "whatever@example.com",
        password: ""
      }
  
      post '/api/v1/sessions', params: body.to_json, headers: { "Content-Type": "application/json", "Accept": "application/json" }
      resp = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
  
      expect(resp.keys).to eq([:errors])
      expect(resp[:errors]).to eq('Invalid user credentials')
    end
  end
end