require "rails_helper"

RSpec.describe Coupon, type: :model do

  describe "validations" do 
    merchant1 = Merchant.create!(name: "Zouper Supplies")     
    coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "AAaa5$", pennies_off: 500, merchant: merchant1, status: 1)
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
  end
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end

  describe "instance methods" do
    it "times_used" do
      merchant1 = Merchant.create!(name: "Zouper Supplies")
   
      customer_1 = Customer.create!(first_name: "Austin", last_name: "Smith")
   
      coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "Save5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_2 = Coupon.create!(name: "SuperSaver%5", code: "Save5%", percent_off: 5, merchant: merchant1, status: 0)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_1)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_2)

      item_1 = Item.create!(name: "Soup", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
      item_2 = Item.create!(name: "Canned Bread", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)

      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)
      ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_2.id)

      expect(coupon_1.times_used).to eq(2)
    end
  end
end