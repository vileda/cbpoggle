class CreateCashBooks < ActiveRecord::Migration
  def self.up
    create_table :cash_books do |t|
      t.string :name
      t.integer :owner_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :cash_books
  end
end
