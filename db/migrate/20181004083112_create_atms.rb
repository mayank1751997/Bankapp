class CreateAtms < ActiveRecord::Migration[5.2]
  def change
    create_table :atms do |t|
    	t.string :location
    	t.string :managed_by
    end
  end
end
