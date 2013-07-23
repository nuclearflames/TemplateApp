class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
        t.belongs_to    :topic
        t.belongs_to    :user
        t.string        :title
        t.string        :description

        t.timestamps
    end
  end
end
