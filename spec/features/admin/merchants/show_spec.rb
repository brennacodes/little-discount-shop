require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  let!(:merchant_1) { Merchant.create!(name: 'Merchant 1') }
  let!(:merchant_2) { Merchant.create!(name: 'Merchant 2') }

  before do
    visit admin_merchant_path(merchant_1)
  end

  it 'shows the merchant name' do
    expect(page).to have_content(merchant_1.name)
  end

  it 'shows the merchant status' do
    expect(page).to have_content(merchant_1.status)
  end

  it "has a link to update the merchants information" do
    click_on "Update Merchant"

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")

    fill_in 'Name', with: "Bob's Burgs"

    click_on "Submit"

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Bob's Burgs")
  end
end
