require 'rails_helper'

RSpec.describe 'item merchant controller' do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }

    it 'returns the merchant for an item' do
      get "/api/v1/items/#{item1.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data][:id]).to be_a(String)
      expect(merchant[:data][:id]).to eq(merchant1.id.to_s)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
      expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    end

    it 'returns an error when the id does not exist' do
      get "/api/v1/items/#{item3.id + 1}/merchant"

      expect(response.status).to eq(404)
    end
end
