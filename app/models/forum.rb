class Forum < ActiveRecord::Base
    belongs_to :user
    has_many :topics

    attr_accessible :title, :description, :name
    paginates_per 10

  	validates_presence_of :title, :description, :name
end
