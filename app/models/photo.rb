class Photo < ActiveRecord::Base
    belongs_to :user

    attr_accessible :title, :description, :picture, :user, :type

    has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

    validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/gif", "image/png"], :message => "File must be of type .png, .jpg, .gif"

    validates_attachment_size :picture, :less_than => 1.megabyte, :message => "File must be smaller than 1 megabyte"

    paginates_per 50 #left to default
end