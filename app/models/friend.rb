class Friend < ActiveRecord::Base
	belongs_to :user

	attr_accessible :friend_id, :friend_type, :confirmed

	validates_presence_of :user_id, :friend_id

	validates_uniqueness_of :friend_id

	def id_as_alias
		return User.find(self.friend_id).alias
	end
	def user_id_as_alias
		return User.find(self.user_id).alias
	end
end