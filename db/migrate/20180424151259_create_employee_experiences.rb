class CreateEmployeeExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_experiences do |t|
      t.references :employee, index: true
      t.references :organization, index: true
      t.boolean :block_created
      t.string :status, limit: 30
      t.date :start_date
      t.date :end_date
      t.boolean :is_currently_employed
      t.string :designation, limit: 50
      t.string :request_reason
      t.date :confirmed_date
      t.string :confirmed_person_name, limit: 50
      t.string :confirmation_note
      t.timestamps
    end
  end
end
