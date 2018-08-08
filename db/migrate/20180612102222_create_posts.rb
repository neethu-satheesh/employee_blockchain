class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :request_type
      t.string :identifier
      t.text :request
      t.text :response
      t.text :blockchain_response

      t.timestamps
    end
  end
end
