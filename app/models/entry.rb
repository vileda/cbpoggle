class Entry < ActiveRecord::Base
  belongs_to :cash_book
  validates_numericality_of :revenue
  validates_numericality_of :expenditure
  validates_presence_of :cash_book_id
end
