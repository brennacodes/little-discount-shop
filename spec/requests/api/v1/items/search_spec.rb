require 'rails_helper'

RSpec.describe 'item find controller', type: :request do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }
  let!(:item4) { Item.create!(name: "X", description: "X!", unit_price: 3.99, merchant_id: merchant2.id) }

  describe 'item search' do
    describe 'happy path' do
      it 'can return all matches for a name search' do
        get api_v1_items_find_all_path, params: { name: 'bu' }
        
        expect(response).to be_successful
        
        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data]).to be_an(Array)
        expect(items[:data].count).to eq 2
      end

      it 'can return all matches for a description search' do
        get api_v1_items_find_all_path, params: { description: 'Y' }

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data]).to be_an(Array)
        expect(items[:data].count).to eq 2
      end

      it 'can return all matches for a max_unit_price search' do
        get api_v1_items_find_all_path, params: { unit_price_max: '15.00' }

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data]).to be_an(Array)
        expect(items[:data].count).to eq 3
      end

      it 'can return all matches for a min_unit_price search' do
        get api_v1_items_find_all_path, params: { unit_price_min: '15.00' }

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data]).to be_an(Array)
        expect(items[:data].count).to eq 1
      end

      it 'can return all matches for a merchant_id search' do
        get api_v1_items_find_all_path, params: { merchant_id: merchant1.id }

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)

        expect(items[:data]).to be_an(Array)
        expect(items[:data].count).to eq 3
      end
    end

    describe 'sad path' do
      it 'returns an error when incorrect params are sent' do
        get api_v1_items_find_all_path, params: { name: '800' }

        expect(response.status).to eq(400)
      end

      it 'returns a 400 error if an empty string is input' do
        get api_v1_items_find_all_path, params: { name: '' }

        expect(response.status).to eq(400)
      end

      it 'returns a 400 error if no search params are input' do
        get api_v1_items_find_all_path, params: { }

        expect(response.status).to eq(400)
      end

      it 'returns an error if a non-integer is input' do
        get api_v1_items_find_all_path, params: { unit_price_max: 'abc' }
        
        expect(response.status).to eq(404)
      end

      it 'returns an error if no matches are found' do
        get api_v1_items_find_all_path, params: { unit_price_min: '1000000.00' }
        
        expect(response.status).to eq(404)

        get api_v1_items_find_all_path, params: { unit_price_max: '0.00' }

        expect(response.status).to eq(404)

        get api_v1_items_find_all_path, params: { unit_price_max: '-1'}

        expect(response.status).to eq(404)
      end

      it 'returns an error when more than one param is input' do
        get api_v1_items_find_all_path, params: { name: 'bu', unit_price_max: '100.00' }

        expect(response.status).to eq(400)

        get api_v1_items_find_all_path, params: { name: 'bu', unit_price_min: '100.00' }

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'items search' do
    it 'can return a single match for a search parameter' do
      get api_v1_items_find_path, params: { name: 'bu' }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items.count).to eq 1
    end

    it 'returns an error if an empty string is input' do
      get api_v1_items_find_path, params: { name: '' }

      expect(response.status).to eq(400)
    end
  end
end
