class Forum < ActiveRecord::Base
    belongs_to :user
    has_many :topics, dependent: :destroy, :order => 'created_at DESC'

    attr_accessible :title, :description
    paginates_per 10

  	validates_presence_of :title, :description
end
