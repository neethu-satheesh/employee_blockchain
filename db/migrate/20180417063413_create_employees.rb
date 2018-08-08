class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name, limit: 50
      t.string :email, limit: 50
      t.string :phone_number, limit: 20
      t.string :address
      t.date :career_start_date
      t.timestamps
    end
  end
end
