module ApplicationHelper
	def global_website_name
		return "The App"
	end
	def global_website_name_linked
		return link_to "The App", "/"
	end

	def register_link
		return link_to "Register", "users/sign_up"
	end

	def signin_link
		return link_to "Signin", "users/sign_in"
	end

	def about_us_text
		return "About US"
	end

	def get_user(id)
		return User.find(id)
	end

	def get_topic(id)
		return Topic.find(id)
	end

	def get_post(id)
		return Post.find(id)
	end

	def get_forum(id)
		return Forum.find(id)
	end
end
