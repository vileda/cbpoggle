class CreateCashBookUserRights < ActiveRecord::Migration
  def self.up
    create_table :cash_book_user_rights, :force => true do |t|
      t.integer :cash_book_id
      t.integer :user_right_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cash_book_user_rights
  end
end
