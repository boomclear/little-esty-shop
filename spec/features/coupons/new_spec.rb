require "rails_helper"

RSpec.describe "Coupon New Page" do 
  describe "Coupon New Page" do 
  
    merchant1 = Merchant.create!(name: "Zouper Supplies")
   
    customer_1 = Customer.create!(first_name: "Austin", last_name: "Smith")
   
    coupon_1 = Coupon.create!(name: "SuperSaver$5", code: "Save$5", pennies_off: 500, merchant: merchant1, status: 1)
    coupon_2 = Coupon.create!(name: "SuperSaver%5", code: "Save%5", percent_off: 5, merchant: merchant1, status: 1)

    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_1)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, coupon: coupon_2)

    item_1 = Item.create!(name: "Soup", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
    item_2 = Item.create!(name: "Canned Bread", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)

    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 0)
    ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 8, status: 0)
    
    it "clicks on link from coupon index page and goes to the create new coupon page" do 
      visit merchant_coupons_path(merchant1)
      click_link("Create new coupon")
      expect(current_path).to eq(new_merchant_coupon_path(merchant1))
    end 

    it "creates a new coupon" do 
      visit(new_merchant_coupon_path(merchant1)) 
      fill_in :name, with: "SuperSaver$10"
      fill_in :code, with: "Save10$"
      select("pennies off", from: :discount_type)
      fill_in :amount, with: "1000"
      click_button(:submit)
      expect(current_path).to eq(merchant_coupons_path(merchant1))
    end

    describe "sad path testing for new coupon form" do
      coupon_3 = Coupon.create!(name: "SuperSaver%15", code: "Save15%", percent_off: 5, merchant: merchant1, status: 1)
      coupon_4 = Coupon.create!(name: "SuperSaver$15", code: "Save15$", pennies_off: 1500, merchant: merchant1, status: 1)

      it "will display a flash message if there are already 5 active coupons for the merchant" do 
      coupon_5 = Coupon.create!(name: "SuperSaver$25", code: "Save25$", pennies_off: 2500, merchant: merchant1, status: 1)

        visit(new_merchant_coupon_path(merchant1)) 
        fill_in :name, with: "SuperSaver$100"
        fill_in :code, with: "Save100$" 
        select("pennies off", from: :discount_type)
        fill_in :amount, with: "1000"
        click_button(:submit)
        expect(page).to have_content("There are already 5 active coupons for this merchant")
      end

      it "will display a flash message if the form is not completely filled out" do 
        visit(new_merchant_coupon_path(merchant1)) 
        fill_in :code, with: "Save1$" 
        select("pennies off", from: :discount_type)
        click_button(:submit)
        expect(page).to have_content("Please fill out the form fully/Not a unique code")
      end
    end
  end
end
