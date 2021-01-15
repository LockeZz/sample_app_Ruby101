class AddActivationToUsers < ActiveRecord::Migration[6.1]
  def change
     add_column :users, :activation_digest, :string
     add_column :users, :activated, :boolean, default: false
     add_column :users, :activated_at, :datetime
     #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
