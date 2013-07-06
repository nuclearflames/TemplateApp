class AddUserDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :aboutme, :string
    add_column :users, :alias, :string
    add_column :users, :birtday, :date
  end
end
