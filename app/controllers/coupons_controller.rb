class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id]) 
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    if !merchant.five_active_coupons?
     if params[:discount_type] = "pennies_off"
        coupon = Coupon.new(name: params[:name], code: params[:code], pennies_off: params[:amount], merchant: merchant, status: 1)
      else
        coupon = Coupon.new(name: params[:name], code: params[:code], percent_off: params[:amount], merchant: merchant, status: 1)
      end
      if coupon.save
        redirect_to merchant_coupons_path(merchant)
      else
        redirect_to new_merchant_coupon_path(merchant)
        flash[:alert] = "Please fill out the form fully/Not a unique code"
      end
    else
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "There are already 5 active coupons for this merchant"
    end
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    coupon = Coupon.find(params[:id])
    if !merchant.five_active_coupons?
      coupon.update(status: params[:coupon_status].to_i)
      redirect_back fallback_location: merchant_coupons_path(merchant)
    else
      redirect_back fallback_location: merchant_coupons_path(merchant)
      flash[:alert] = "There are already 5 active coupons for this merchant"
    end
  end

end