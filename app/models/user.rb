class User < ActiveRecord::Base
	has_many :links
	has_many :posts

	def write_post(post_params, board)
		params[:board_id] = board.id
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
