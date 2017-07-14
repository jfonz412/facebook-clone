module ApplicationHelper
	def notifications
		if current_user.notices == 0
			number_of_notices = nil
		else
			number_of_notices = "#{current_user.notices.count}"
		end
	end

	def profile_and_notices
    badge = content_tag :span, notifications, class: 'badge'
    text = raw "Profile #{badge}"
	end
end
