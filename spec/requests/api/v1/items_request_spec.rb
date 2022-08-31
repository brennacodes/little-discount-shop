require 'rails_helper'

RSpec.describe 'items requests' do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }

  it 'can return all items' do
    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    item = items[:data][0]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:name]).to eq(item1.name)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:description]).to eq(item1.description)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:unit_price]).to eq(item1.unit_price)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to eq(item1.merchant_id)
  end

  describe 'item show' do
    it 'can return the information for one item' do
      get api_v1_item_path(item1.id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_an(String)
      expect(item[:data][:attributes][:name]).to eq('Dip')

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_an(String)
      expect(item[:data][:attributes][:description]).to eq('Hot')

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes][:unit_price]).to eq(3.99)
    end

    it 'returns the proper error when item does not exist' do
      get api_v1_item_path(item3.id + 1)

      expect(response.status).to eq(404)
    end
  end

  describe 'item create' do
    it 'can create a new item' do
      item_params = {
        name: 'columbian coffee',
        description: 'dark roast, medium grind',
        unit_price: 3.99,
        merchant_id: merchant1.id
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      item4 = Item.last

      expect(response).to be_successful
      expect(item4.name).to eq(item_params[:name])
      expect(item4.description).to eq(item_params[:description])
      expect(item4.unit_price).to eq(item_params[:unit_price])
      expect(item4.merchant_id).to eq(item_params[:merchant_id])
    end

    it 'returns an error if an item cannot be created' do
      item_params = {
        name: '',
        description: '',
        unit_price: '',
        merchant_id: merchant1.id
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end

  describe 'item update' do
    it 'can update an existing item' do
      expect(item1.name).to eq('Dip')

      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate({ item: { name: 'Sandwich' } })

      expect(response).to be_successful
      expect(item1.reload.name).to eq('Sandwich')
    end

    it 'returns the proper error when item does not exist' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/items/50000000000000000", headers: headers, params: JSON.generate({ item: { name: 'Sandwich' } })

      expect(response.status).to eq(404)
    end

    it 'returns the proper error when an item cannot be created' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate({ item: { name: '' } })

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end

  describe 'item destroy' do
    it 'can destroy an item' do
      expect(Item.count).to eq(3)
      expect(item1).to be_a(Item)

      delete "/api/v1/items/#{item1.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(2)
      
      get "/api/v1/items/#{item1.id}"
      expect(response.status).to eq(404)
    end
  end
end
