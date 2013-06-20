class Board < ActiveRecord::Base
	has_many :links, dependent: :destroy
	has_many :posts, dependent: :destroy

	def add_member (user, privilege)
		links.build(user_id: user.id, privilege: privilege).save
	end

	def remove_member (user)
		links.each do |link|
			link.destroy if link.user = user
		end
	end

	def has_member? (user)
		links.any? do |link|
			link.user == user
		end
	end

	def has_post? (post)
		posts.any? do |_post|
			_post.id == post.id 
		end
	end

	def main_posts
		result = []
		posts.each do |post|
			result << post if post.location == "main"
		end

		result
	end

	def temp_posts
		result = []
		posts.each do |post|
			result << post if post.location == "temp"
		end

		result
	end
end
