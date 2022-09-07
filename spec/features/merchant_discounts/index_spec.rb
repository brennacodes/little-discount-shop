require 'rails_helper'

RSpec.describe 'merchant discounts index page', type: :feature do
  let!(:merchant) { Merchant.create!(name: 'Merchant 1') }
  let!(:item_1) { merchant.items.create!(name: 'Item 1', description: 'Item 1 description', unit_price: '100') }
  let!(:customer) { Customer.create!(first_name: 'John', last_name: 'Doe') }
  let!(:invoice) { Invoice.create!(customer_id: customer.id, status: 'in progress') }
  let!(:invoice_item_1) { InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: 'packaged') }
  let!(:discount) { Discount.create!(merchant_id: merchant.id, name: 'Sale sale sale!', percent: 11, qty_threshold: 11) }
  let!(:discount_1) { Discount.create!(merchant_id: merchant.id, name: 'DEALS!', percent: 22, qty_threshold: 22) }
  let!(:discount_2) { Discount.create!(merchant_id: merchant.id, name: 'SAVE!', percent: 33, qty_threshold: 33) }

  before do
    visit "/merchants/#{merchant.id}/discounts"
  end

  describe 'links' do
    it 'has a link to create a new discount' do
      expect(page).to have_link('Create a New Bulk Discount')

      click_on 'Create a New Bulk Discount', match: :first

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/new")
    end

    it 'has a link to view a discount' do
      expect(page).to have_link('View Discount')

      click_on 'View Discount', match: :first

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}")
    end

    it 'has a link next to each discount to delete it' do 
      within "##{discount.id}-delete" do
        expect(page).to have_link("Delete Discount") 
      end

      within "##{discount_1.id}-delete" do
        expect(page).to have_link("Delete Discount") 
      end

      within "##{discount_2.id}-delete" do
        expect(page).to have_link("Delete Discount") 
      end
    end

    it 'redirects back to index and no longer shows item after it is deleted' do
      within "##{discount.id}-percent" do
        expect(page).to have_content("11%")
      end

      within "##{discount.id}-delete" do
        click_on "Delete Discount", match: :first
      end

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts")
      expect(page).not_to have_content('11%')
    end
  end

  describe 'information' do
    it 'shows all of a merchants discounts' do
      within "#discounts-table" do
        expect(page).to have_content("#{discount.percent}%")
        expect(page).to have_content("#{discount_1.percent}%")
        expect(page).to have_content("#{discount_2.percent}%")
      end
    end

    it 'shows the percentage discount and quantity threshold for each merchant discount' do
      within "#discounts-table" do
        within "##{discount.id}-percent" do
          expect(page).to have_content("#{discount.percent}%")
        end

        within "##{discount.id}-qty" do
          expect(page).to have_content(discount.qty_threshold)
        end
      
        within "##{discount_1.id}-percent" do
          expect(page).to have_content("#{discount_1.percent}%")
        end
    
        within "##{discount_1.id}-qty" do
          expect(page).to have_content(discount_1.qty_threshold)
        end

        within "##{discount_2.id}-percent" do
          expect(page).to have_content("#{discount_2.percent}%")
        end

        within "##{discount_2.id}-qty" do
          expect(page).to have_content(discount_2.qty_threshold)
        end
      end
    end
  end

  describe 'holiday discounts' do
    it 'displays the next 3 updcming holidays' do
      within "h2" do
        expect(page).to have_content("Upcoming Holidays")
      end

      within "#holiday-name-1" do
        expect(page).to have_content("Columbus Day")
      end

      within "#holiday-name-2" do
        expect(page).to have_content("Veterans Day")
      end

      within "#holiday-name-3" do
        expect(page).to have_content("Thanksgiving Day")
      end

      within "#holiday-date-1" do
        expect(page).to have_content("Monday, October 10, 2022")
      end

      within "#holiday-date-2" do
        expect(page).to have_content("Friday, November 11, 2022")
      end

      within "#holiday-date-3" do
        expect(page).to have_content("Thursday, November 24, 2022")
      end
    end

    it 'has a link to create a new holiday discount' do
      expect(page).to have_link('Create Holiday Discount')

      click_on 'Create Holiday Discount', match: :first
    end

    it 'prefills a form to create a new holiday discount' do
      expect(current_path).to eq("/merchants/#{merchant.id}/discounts")
      
      click_on 'Create Holiday Discount', match: :first

      expect(current_path).to eq("/merchants/#{merchant.id}/discounts/new")

      expect(find_field('Name').value).to eq("Columbus Day")
      expect(find_field('Percent').value).to eq("30")
      expect(find_field('discount[qty_threshold]').value).to eq("2")
    end
  end
end