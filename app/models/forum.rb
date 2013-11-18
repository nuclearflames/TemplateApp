class Forum < ActiveRecord::Base
    belongs_to :user
    has_many :topics, dependent: :destroy

    attr_accessible :title, :description
    paginates_per 10

  	validates_presence_of :title, :description
end
