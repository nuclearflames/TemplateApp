class Topic < ActiveRecord::Base
    belongs_to :user
    belongs_to :forum
    has_many :posts

    attr_accessible :title, :description, :user_id, :id, :forum_id
end
