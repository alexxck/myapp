class RemoveName < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :name
    remove_column :posts, :name
  end
end
