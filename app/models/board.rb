class Board < ActiveRecord::Base
	has_many :links
	has_many :posts

	def add_member (user, privilege)
		links.build(user_id: user.id, privilege: privilege).save
	end

	def has_member? (user)
		links.any? do |link|
			link.user == user
		end
	end


end
