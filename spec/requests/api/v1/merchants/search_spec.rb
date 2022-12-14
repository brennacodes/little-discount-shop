require 'rails_helper'

RSpec.describe 'merchant search controller' do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:merchant3) { Merchant.create!(name: "Bobby's BBQ") }

  describe 'find path' do
    xit 'returns a single merchant that matches search input' do
      get api_v1_merchants_find_path, params: { name: 'Bob' }

      expect(response).to be_successful

      response = JSON.parse(response.body, symbolize_names: true)

      expect(response[:data].count).to eq(1)

      merchant = response[:data].first

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:id]).to eq(merchant1.id)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes][:name]).to eq("Billy Bob's Burgers")
    end

    it 'returns a 400 error if an empty string is input' do
      get api_v1_merchants_find_path, params: { name: ''}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:errors]).to eq("Please enter a valid search parameter and try again.")
    end

    it 'raises error when there is no match' do
      get api_v1_merchants_find_path, params: { name: '99' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:errors]).to eq("Please enter a valid search parameter and try again.")
    end
  end

  describe 'find all path' do
    xit 'returns all merchants that match search input' do
      get api_v1_merchants_find_all_path, params: { name: 'Bob' }
      
      expect(response).to be_successful

      response = JSON.parse(response.body, symbolize_names: true)

      expect(response[:data].count).to eq(2)

      merchant = response[:data]

      expect(merchant).to be_an(Array)
      expect(merchant.first[:id]).to eq(merchant1.id)
      expect(merchant.last[:id]).to eq(merchan3.id)
    end

    it 'returns a 400 error if an empty string is input' do
      get api_v1_merchants_find_all_path, params: { name: ''}

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'raises error when there is no match' do
      get api_v1_merchants_find_all_path, params: { name: '99' }

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:errors]).to eq("Please enter a valid search parameter and try again.")
    end
  end
end
