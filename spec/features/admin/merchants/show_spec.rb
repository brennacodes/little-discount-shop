require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  let!(:merchant_1) { Merchant.create!(name: 'Merchant 1') }
  let!(:merchant_2) { Merchant.create!(name: 'Merchant 2') }

  before do
    @admin = User.create!(username: "Admin", email: "admin@admin.com", password: "admin", role: 2)

    visit root_path

    fill_in :username, with: @admin.username
    fill_in :password, with: @admin.password

    click_button "Login", match: :first

    click_on "Admin Dashboard"
    click_on "Merchants", match: :first
    click_on "#{merchant_1.name}"
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
