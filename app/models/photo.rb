class Photo < ActiveRecord::Base
    belongs_to :user

    attr_accessible :title, :description, :picture, :user, :type

    has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

    paginates_per 50 #left to default
end
