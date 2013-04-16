class AddAdminToUsers < ActiveRecord::Migration
  def change
    # The table, the new column, the type, the options hash
    add_column :users, :admin, :boolean, default: false
  end
end
