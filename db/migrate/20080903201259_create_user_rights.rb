class CreateUserRights < ActiveRecord::Migration
  def self.up
    create_table :user_rights do |t|
      t.integer :user_id
      t.integer :right
      t.integer :cash_book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_rights
  end
end
