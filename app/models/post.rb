class Post < ActiveRecord::Base
	self.inheritance_column = nil
	
	belongs_to :user
	belongs_to :board
	has_many :notifications
end
