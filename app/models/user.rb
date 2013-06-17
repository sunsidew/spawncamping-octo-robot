class User < ActiveRecord::Base
	has_many :links, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :notifications, dependent: :destroy

	def notify(post)
		notifications.build(post_id: post.id, flag: 1).save		
	end

	def write_post(post_params, board)
		params = {top: post_params[:top].to_i, left: post_params[:left].to_i, story: post_params[:text], type: post_params[:type], board_id: board.id}
		posts.build(params)
	end

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.picture = auth.info.image
	    user.save!
	  end
	end
end
