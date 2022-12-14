# require 'rails_helper'
#
# RSpec.describe 'get /munchies' do
#
#   it 'returns json data to plan for munchies', :vcr do
#     headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
#     params = {
#
#       "location":  "denver, co",
#       "food": "Chinese"
#     }
#
#     get '/api/v1/munchies', headers: headers, params: params
#
#     munchie_response = JSON.parse(response.body, symbolize_names: true)
#
#     expect(response).to be_successful
#     expect(response.status).to eq(200)
#     expect(munchie_response[:data]).to be_a Hash
#     expect(munchie_response[:data][:id]).to eq(nil)
#     expect(munchie_response[:data][:type]).to eq("munchie")
#     expect(munchie_response[:data][:attributes]).to be_a Hash
#
#
#     expect(munchie_response[:data][:attributes][:forecast]).to be_a Hash
#     expect(munchie_response[:data][:attributes][:forecast][:summary]).to be_an String
#     expect(munchie_response[:data][:attributes][:forecast][:temperature]).to be_an Numeric
#     expect(munchie_response[:data][:attributes][:restaurant]).to be_an Hash
#     expect(munchie_response[:data][:attributes][:restaurant][:name]).to be_an String
#     expect(munchie_response[:data][:attributes][:restaurant][:name]).to eq("Taste of China")
#     expect(munchie_response[:data][:attributes][:restaurant][:address]).to be_an String
#
#   end
# end
