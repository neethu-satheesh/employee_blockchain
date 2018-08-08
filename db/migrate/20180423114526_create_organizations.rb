class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 50
      t.string :registration_id, limit: 50
      t.string :email, limit: 50
      t.string :phone_number, limit: 20
      t.string :address
      t.timestamps
    end
  end
end
