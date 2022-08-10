# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
require 'faker'
require 'factory_bot_rails'

800.times do 
  FactoryBot.create(:discount)
end

50.times do
  FactoryBot.create(:discount_invoice_item)
end
