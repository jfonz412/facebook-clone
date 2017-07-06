module ApplicationHelper
	def notifications
		if current_user.inverse_friendships.pending.count == 0
			number_of_notices = nil
		else
			number_of_notices = "(#{current_user.inverse_friendships.pending.count})"
		end
	end
end
