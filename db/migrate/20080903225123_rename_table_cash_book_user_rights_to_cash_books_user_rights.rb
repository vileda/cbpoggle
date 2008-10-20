class RenameTableCashBookUserRightsToCashBooksUserRights < ActiveRecord::Migration
  def self.up
    rename_table :cash_book_user_rights, :cash_books_user_rights
  end

  def self.down
    rename_table :cash_books_user_rights, :cash_book_user_rights
  end
end
