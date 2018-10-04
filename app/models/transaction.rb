class Transaction < ApplicationRecord
  belongs_to :atm
  belongs_to :account
  validates :date, :operation, :amount, presence: true
  validates :amount, numericality: true
  validates :operation, inclusion: { in: %w(deposite withdrawal)}
  validates :check_amount  
  after_save :withdrawal_amount_and_check_balance
  after_save :withdrawal_amount
  after_save :update_balance_after_deposit
  after_save :left_balance_after_withdrawal
  private
  def check_amount
  	if self.amount <= 0
      errors.add(:base, "less than zero balance is not allowed")  
    end
  end
  def withdrawal_amount_and_check_balance
    if self.account.balance < self.amount && sel.operation == 'withdrawal'
      errors.add(:amount, "not permitted amount not balance enough")
    end
  end
  def withdrawal_amount
    if self.amount % '100' == '0' && self.operation == 'withdrawal'
      errors.add(:amount, "not permitted amount not balance enough")
    end
  end  
  def update_balance_after_deposite
    if self.operation == 'deposite'
      new_balance = self.account.balance + self.amount
      self.account.update.attributes(balance: new_balance)
    end
  end
  def left_balance_after_withdrawal
    if self.operation == 'withdrawal'    
      new_balance = self.account.balance - self.amount
      unless self.account.update_attributes(balance: new_balance)
      raise "requested amount can not be withdraw"
    end
  end
end