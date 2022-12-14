
require 'rails_helper'
RSpec.describe 'Roadtrip Request' do
  before (:each) do
    @user = User.create(email: "pedro@gmail.com", password: "password", password_confirmation: "password" )
  end
  it 'returns json response for a road trip when a valid API key is given', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(road_trip).to have_key(:data)
    expect(road_trip[:data]).to have_key(:id)
    expect(road_trip[:data]).to have_key(:type)
    expect(road_trip[:data]).to have_key(:attributes)
    expect(road_trip[:data][:type]).to eq("roadtrip")
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
  end

  it 'returns an error response for incorrect api key', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "1234"
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(road_trip).to have_key(:message)
    expect(road_trip[:message]).to eq("invalid api key")
  end

  it 'returns trip is impossible when route cannot be mapped', :vcr do
    body = {
        "origin": "Denver,CO",
        "destination": "Tokyo",
        "api_key": @user.api_key
    }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)

    expect(road_trip).to have_key(:error)

    expect(road_trip[:error]).to be_a(String)

    expect(road_trip[:error]).to eq("trip is impossible")
  end
end
