require 'rails_helper'

RSpec.describe 'merchants controller' do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:merchant3) { Merchant.create!(name: "Bobby's BBQ") }

  it 'sends a list of merchants' do
    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)

    merchant = merchants[:data].first

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String) 
  end

  describe 'show' do
    it 'returns a single merchant' do
      get api_v1_merchant_path(merchant1.id)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_an(String)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_an(String)
    end

    it 'gives a 404 error when id is invalid' do
      get api_v1_merchant_path(1)

      expect(response.status).to eq(404)
    end
  end
end
