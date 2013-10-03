class Message < ActiveRecord::Base

    attr_accessible :title, :content, :attachment, :recipient_id

    has_attached_file :attachment, :default_url => "/images/:style/missing.png"

    paginates_per 10

end
