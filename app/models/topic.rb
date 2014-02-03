class Topic < ActiveRecord::Base
    belongs_to :user
    belongs_to :forum
    has_many :posts, dependent: :destroy, :order => 'created_at DESC'

    attr_accessible :title, :description, :user_id, :id, :forum_id
    validates_presence_of :title, :description

    paginates_per 10
end
