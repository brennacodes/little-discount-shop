require 'rails_helper'

RSpec.describe 'new merchant discount page', type: :feature do
  let!(:merchant) { Merchant.create!(name: 'Merchant 1') }

  before do
    visit "/merchants/#{merchant.id}/discounts/new"
  end

  it 'has a form to create a new discount' do
    expect(page).to have_field("Name")
    expect(page).to have_field("Percent")
    expect(page).to have_field("discount[qty_threshold]")
    expect(page).to have_button("Submit")

    fill_in "Name", with: "Percent Off"
    fill_in "Percent", with: "10"
    fill_in "discount[qty_threshold]", with: "10"
  end

  it 'redirects to the merchant discounts index page' do
    fill_in "Name", with: "Newest Discount"
    fill_in "Percent", with: "99"
    fill_in "discount[qty_threshold]", with: "99"

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{merchant.id}/discounts")
    expect(page).to have_content("Discount was successfully created.")
    expect(page).to have_content("99%")
  end
end