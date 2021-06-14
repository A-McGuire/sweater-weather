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
    expect(response.body).to eq(
      {
        data: {
          type: "users",
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.auth_token
          }
        }
      })

    expect(user.class).to eq(User)
    expect(user.email).to eq('whatever@example.com')
  end

  it 'responds with a 400 level status with description why in body if failed'
end