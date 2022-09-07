require 'rails_helper'

RSpec.describe 'admin invoices index' do
  let!(:sally) { Customer.create!(first_name: 'Sally', last_name: 'Smith') }
  let!(:invoice_1) { Invoice.create!(customer_id: sally.id, status: 1) }
  let!(:invoice_2) { Invoice.create!(customer_id: sally.id, status: 1) }
  let!(:invoice_3) { Invoice.create!(customer_id: sally.id, status: 1) }

  before do
    @admin = User.create!(username: "Admin", email: "admin@admin.com", password: "admin", role: 2)

    visit root_path

    fill_in :username, with: @admin.username
    fill_in :password, with: @admin.password

    click_button "Login", match: :first

    click_on "Admin Dashboard"

    click_on "Invoices", match: :first
  end

  it 'has list of all Invoice ids in the system' do
    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("#{invoice_2.id}")
    expect(page).to have_content("#{invoice_3.id}")
  end

  it 'has a link to view each invoice' do
    expect(page).to have_link("#{invoice_1.id}")
    expect(page).to have_link("#{invoice_2.id}")
    expect(page).to have_link("#{invoice_3.id}")
  end

  it 'links to each invoice show page' do
    click_link "#{invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
  end
end
