module ApplicationHelper
	def global_website_name
		return "templateApp"
	end
	def global_website_name_linked
		return link_to "templateApp", "/"
	end

	def register_link
		return link_to "Register", "users/sign_up"
	end

	def signin_link
		return link_to "Sign in", "users/sign_in"
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

	#Takes the value to count and what to name it
	def no_results(value, name)
		string = "<div class='row'><div class='col-sm-12'><p>No " + name + " are available to view</p></div></div>"
		if value.count == 0
			return string;
		end
		return "<div></div>"
	end
end
