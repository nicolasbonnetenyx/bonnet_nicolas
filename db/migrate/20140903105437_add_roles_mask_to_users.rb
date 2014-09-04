class AddRolesMaskToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_mask, :integer, :default => 4
  end
  
  def self.down
    remove_column :users, :roles_mask
  end
end
