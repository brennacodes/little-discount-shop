require 'rails_helper'

RSpec.describe "merchants items", type: :request do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 399, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 1099, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 2950, merchant_id: merchant1.id) }

  describe 'index' do
    it 'returns all of a merchants items' do
      get api_v1_merchants_items_path(merchant1.id)

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].count).to eq(3)
      expect(items).to be_a(Hash)

      item = items[:data].first
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to eq(item1.id.to_s)

      attributes = item[:attributes]
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_an(String)
      expect(attributes[:name]).to eq(item1.name)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_an(String)
      expect(attributes[:description]).to eq(item1.description)

      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_an(Integer)
      expect(attributes[:unit_price]).to eq(item1.unit_price)
    end

    it 'gives a 404 error when id is invalid' do
      get api_v1_merchants_items_path("#{merchant1.id + 1}")

      expect(response.status).to eq(404)
    end
  end
end
