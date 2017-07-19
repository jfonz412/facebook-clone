module ApplicationHelper
	def notice_count
		if current_user.notices.count == 0
			number_of_notices = nil
		else
			number_of_notices = "#{current_user.notices.count}"
		end
	end

	def profile_badge
    badge = content_tag :span, notice_count, class: 'badge'
    text = raw "Profile #{badge}"
	end

	def construct_notices
		notices = []
		current_user.notices.each do |notice|
			type = notice.notice_type
			notices << notice_message(type)
		end
		notices
	end
end

def notice_message(type)
	message = "New Friend Requests!" if type == "Friendship"
	message = "Someone liked your post!" if type == "Like"
	message = "Someone commented on your post!" if type == "Comment"
	message
end

