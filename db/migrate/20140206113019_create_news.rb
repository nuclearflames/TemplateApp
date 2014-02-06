class CreateNews < ActiveRecord::Migration
	def change
		create_table :news do |t|
			t.belongs_to    :user
			t.string       	:title
			t.string        :description

			t.timestamps
		end
	end
end
