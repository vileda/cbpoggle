class UserRight < ActiveRecord::Base
  belongs_to :cash_book
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :cash_book_id
end
