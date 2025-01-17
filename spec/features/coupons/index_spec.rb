require "rails_helper"

RSpec.describe "Coupon Index Page" do 
  describe "Coupon Index Page" do

    it "shows coupons and their attributes" do
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

      visit merchant_coupons_path(merchant1)
      expect(page).to have_content(coupon_1.pennies_off)
      expect(page).to have_content(coupon_2.percent_off)
      expect(page).to have_link(coupon_1.name)
      expect(page).to have_link(coupon_2.name)
      expect(page).to have_content(coupon_1.status)
      expect(page).to have_content(coupon_2.status)
    end

    it "has a create new coupon link" do 
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

      visit merchant_coupons_path(merchant1)
      expect(page).to have_link("Create new coupon")
    end

    it "separates inactive from active coupons" do
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

      visit merchant_coupons_path(merchant1)
      within("#active_coupons") do
        expect(page).to have_content(coupon_1.name)
      end
      within("#inactive_coupons") do
        expect(page).to have_content(coupon_2.name)
      end
    end
  end
end