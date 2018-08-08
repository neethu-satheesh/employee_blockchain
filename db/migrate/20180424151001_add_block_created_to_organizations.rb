class AddBlockCreatedToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :block_created, :boolean, default: false
  end
end
