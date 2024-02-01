class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims do |t|
      t.string :claim_username
      t.string :created_by
      t.text :claim_data
      t.string :customer_name
      t.string :claim_status

      t.timestamps
    end
  end
end
