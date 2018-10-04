class Manager < ApplicationRecord
	belongs_to :branch
  validates :name, :address, :designation, :age, :salary, :phone_no :presence:true
  validates :age, :salary , numericality: { only_integer: true }
  validates :phone_no, length: { is: 10 }, numericality: { only_integer: true }
  validates :check_age, on [:create]
  validates :check_salary
	private
 		def check_age
			if self.age < 18 
				errors.add(:base, "Not eligible to be a manager")
    	end
  	end
  	def check_salary
  		if self.salary <= 0
  			errors.add(:salary, "Not eligible to be a manager")
  		end
  	end
end	





