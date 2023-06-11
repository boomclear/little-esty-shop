class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total
    ii = total_revenue
    if self.coupon.pennies_off
      pennies_off = self.coupon.pennies_off
      ii - pennies_off
    elsif self.coupon.percent_off
      percent_off = self.coupon.percent_off
      division = percent_off / 100.0
      multi = ii * division
      ii - multi
    end
  end
end
