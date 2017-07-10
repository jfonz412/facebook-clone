module LikesHelper
	def like_or_likes(post_count)
		if post_count == 1
			"likes"
		else
			"like"
		end
	end
end
