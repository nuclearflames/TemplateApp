class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic
  
    attr_accessible :title, :description, :topic_id
end
