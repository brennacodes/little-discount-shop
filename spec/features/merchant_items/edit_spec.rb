require 'rails_helper'

RSpec.describe 'merchant items update page', type: :feature do
  let!(:merchant_1) { Merchant.create!(name: 'Micheal Jordan') }
  let!(:merchant_2) { Merchant.create!(name: 'John Doe') }
  let!(:item_1) { Item.create!(name: 'Item 1', description: 'Description 1', unit_price: 100, merchant_id: merchant_1.id, status: 0) }
  let!(:item_2) { Item.create!(name: 'Item 2', description: 'Description 2', unit_price: 200, merchant_id: merchant_1.id, status: 0) }
  let!(:nicole) { Customer.create!(first_name: 'Nicole', last_name: 'Smith') }
  let!(:invoice_1) { Invoice.create!(customer_id: nicole.id, status: 0) }

  before(:each) do
    visit edit_merchant_item_path(merchant_1, item_1)
  end

  it 'can update an item' do
    expect(find_field('Name').value).to eq(item_1.name)
    expect(find_field('Unit price').value).to eq(item_1.unit_price.to_s)
    expect(find_field('Description').value).to eq(item_1.description)

    fill_in 'Name', with: 'Item 1 Updated'
    fill_in 'Unit price', with: '111'
    fill_in 'Description', with: 'Description 1 Updated'

    click_on 'Submit'

    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")

    expect(page).to have_content("Item was successfully updated")

    expect(page).to have_content("Item 1 Updated")
    expect(page).to have_content("Description 1 Updated")
    expect(page).to have_content("$1.11")
  end
end