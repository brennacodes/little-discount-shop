require 'rails_helper'

RSpec.describe 'merchant items show page', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan') }
  let!(:merchant_2) { Merchant.create!(name: 'John Doe') }
  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 0) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 0) }
  let!(:nicole) { Customer.create!(first_name: 'Nicole', last_name: 'Smith') }
  let!(:invoice_1) { Invoice.create!(customer_id: nicole.id, status: 0) }


  before(:each) do
    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"
  end

  it 'displays the item name' do
    expect(page).to have_content(item_1.name)
    expect(page).not_to have_content(item_2.name)
  end

  it 'displays the item description' do
    expect(page).to have_content(item_1.description)
    expect(page).not_to have_content(item_2.description)
  end

  it 'displays the item unit price' do
    expect(page).to have_content((item_1.unit_price / 100.00).to_s)
    expect(page).not_to have_content((item_2.unit_price / 100.00).to_s)
  end

  it 'has a link to edit the item information' do
    expect(page).to have_link('Edit Item')
  end
end