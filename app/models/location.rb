class Location < ActiveRecord::Base
   # belongs_to :user

    # Setup accessible (or protected) attributes for your model
    attr_accessible :user_id, :location, :city, :town, :street, :houseno, :postcode, :lat, :lng

end