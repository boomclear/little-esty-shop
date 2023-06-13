require "rails_helper"

RSpec.describe "Coupon show Page" do 
  describe "Coupon show Page" do 
    it "displays a coupon's attributes and the count of times it's been used" do 
      merchant1 = Merchant.create!(name: "Zouper Supplies")
   
      customer_1 = Customer.create!(first_name: "Austin", last_name: "Smith")
     
      coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_2 = Coupon.create!(name: "SuperSaver%5", code: "5%", percent_off: 5, merchant: merchant1, status: 1)
  
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_1)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_2)
  
      item_1 = Item.create!(name: "Soup", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
      item_2 = Item.create!(name: "Canned Bread", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)
  
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)
      ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)
    
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction3 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_2.id)

      visit merchant_coupon_path(merchant1, coupon_1)
      expect(page).to have_content(coupon_1.pennies_off)
      expect(page).to_not have_link(coupon_2.name)
      expect(page).to have_content(coupon_1.status)
      expect(page).to have_content("Times Used: 2")
    end

    it "shows a button that activates or deactivates a coupon" do
      merchant1 = Merchant.create!(name: "Zouper Supplies")
   
      customer_1 = Customer.create!(first_name: "Austin", last_name: "Smith")
     
      coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_2 = Coupon.create!(name: "SuperSaver%5", code: "5%", percent_off: 5, merchant: merchant1, status: 1)
  
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_1)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_2)
  
      item_1 = Item.create!(name: "Soup", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
      item_2 = Item.create!(name: "Canned Bread", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)
  
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)
      ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)
    
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_2.id)

      visit merchant_coupon_path(merchant1, coupon_1)
      expect(page).to have_button("Deactivate")
      click_button("Deactivate")
      expect(page).to have_content("Coupon status: inactive")
      expect(current_path).to eq(merchant_coupon_path(merchant1, coupon_1))
      
      expect(page).to have_button("Activate")
      click_button("Activate")
      expect(current_path).to eq(merchant_coupon_path(merchant1, coupon_1))
      expect(page).to have_content("Coupon status: active")

    end

    it "will not activate a coupon if there are already 5 active coupons" do
      merchant1 = Merchant.create!(name: "Zouper Supplies")
   
      customer_1 = Customer.create!(first_name: "Austin", last_name: "Smith")
     
      coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_2 = Coupon.create!(name: "SuperSaver%5", code: "5%", percent_off: 5, merchant: merchant1, status: 1)
  
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_1)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_2)
  
      item_1 = Item.create!(name: "Soup", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
      item_2 = Item.create!(name: "Canned Bread", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)
  
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)
      ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)
    
      transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
      transaction2 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_2.id)

      coupon_3 = Coupon.create!(name: "SuperSaver$5", code: "asdfasdf5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_4 = Coupon.create!(name: "SuperSaver%5", code: "afsfa5%", percent_off: 5, merchant: merchant1, status: 1)
      coupon_5 = Coupon.create!(name: "SuperSaver$5", code: "asd5$", pennies_off: 500, merchant: merchant1, status: 1)
      coupon_6 = Coupon.create!(name: "SuperSaver%5", code: "asdf5%", percent_off: 5, merchant: merchant1, status: 0)
      visit merchant_coupon_path(merchant1, coupon_6)
      click_button('Activate')
      expect(page).to have_content("There are already 5 active coupons for this merchant")
    end
  end
end