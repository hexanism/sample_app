class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    # Adds an index on the email column.
    # With the unique: true option this 
    # enforces unique addresses in the database
    # rather than just the saving of the record.
    add_index :users, :email, unique: true
  end
end
