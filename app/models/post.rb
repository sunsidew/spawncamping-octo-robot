class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :board

	self.inheritance_column = nil
end
