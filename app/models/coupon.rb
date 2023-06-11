class Coupon < ApplicationRecord
  validates_presence_of :name, :code
  validates :code, uniqueness: true

  has_many :invoices
  belongs_to :merchant
  has_many :transactions, through: :invoices

  enum status: ['inactive', 'active']

  def times_used
    self.invoices.joins(:transactions).where(transactions: { result: 1 } ).count
  end
end