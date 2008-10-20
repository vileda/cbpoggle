class CashBook < ActiveRecord::Base
  has_many                  :entries
  has_and_belongs_to_many   :user_rights
  has_many                  :users, :through => :user_rights
  belongs_to                :owner, :class_name => "User", :foreign_key => "owner_id"
  
  validates_presence_of     :owner_id
  validates_presence_of     :name
  validates_uniqueness_of   :name
end
