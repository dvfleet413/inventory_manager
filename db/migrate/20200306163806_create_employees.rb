class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :company_id
    end
  end
end
