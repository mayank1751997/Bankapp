class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
    	t.string :type
      t.string :date_of_opening
      t.integer :account_no
      t.float :balance
      t.references :user, index: true, foreign_key: true
      t.references :bank, index: true, foreign_key: true    
    end
  end
end
