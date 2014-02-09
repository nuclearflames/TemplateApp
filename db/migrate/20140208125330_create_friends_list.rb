class CreateFriendsList < ActiveRecord::Migration
	def change
		create_table :friends do |t|
			t.belongs_to    :user
			t.integer		:friend_id, :required => true
			t.string        :friend_type
			t.boolean       :confirmed, :default => 0

			t.timestamps
		end
	end
end