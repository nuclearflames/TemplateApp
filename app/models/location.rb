class Location < ActiveRecord::Base
    belongs_to :user

    # Setup accessible (or protected) attributes for your model
    attr_accessible :user_id, :country, :city, :town, :street, :houseno, :postcode, :lat, :lng

    validates_presence_of :user_id, :country, :city, :town, :lat, :lng
end