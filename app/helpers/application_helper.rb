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
end
