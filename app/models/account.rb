class Account < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  has_many :transactions
  validates :type, :date_of_opening, :account_no, :balance , presence: true
  validates :balance, numericality: true
  validates :account_no, numericality: { in: %w(Saving_Account Current_Account)}
  validates :check_valid_amount, on: [:create]
  before_update :check_balance_have_non_zero,on: [:update]
  private
   def check_valid_amount
    if self.balance < 500
      errors.add(:base, "can't open an Account")
    end
  end
  def check_balance_have_non_zero
  	if self.balance <= 0
  		errors.add(:balance, "can not open account")
  	end
  end
end
