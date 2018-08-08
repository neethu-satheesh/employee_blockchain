class AddBlockCreatedToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :block_created, :boolean, default: false
  end
end
