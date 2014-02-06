class News < ActiveRecord::Base
    belongs_to :user

    attr_accessible :title, :description
    paginates_per 1

  	validates_presence_of :title, :description
end
