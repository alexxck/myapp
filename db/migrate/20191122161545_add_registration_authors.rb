# frozen_string_literal: true

class AddRegistrationAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :email, :string
    add_index :authors, :email, unique: true
    add_column :authors, :password_digest, :string
    add_column :authors, :admin, :boolean, default: false
  end
end
