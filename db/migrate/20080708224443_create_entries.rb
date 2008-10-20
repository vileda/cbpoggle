class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.date :date
      t.string :purpose
      t.decimal :revenue, :precision => 8, :scale => 2, :default  => 0.00
      t.decimal :expenditure, :precision => 8, :scale => 2, :default  => 0.00
      t.integer :cash_book_id
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :entries
  end
end
