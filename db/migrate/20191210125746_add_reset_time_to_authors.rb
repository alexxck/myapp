# frozen_string_literal: true

class AddResetTimeToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :password_reset_sent_at, :datetime
  end
end
