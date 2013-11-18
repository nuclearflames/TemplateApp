class Topic < ActiveRecord::Base
    belongs_to :user
    belongs_to :forum
    has_many :posts, dependent: :destroy

    attr_accessible :title, :description, :user_id, :id, :forum_id
    paginates_per 10
end
