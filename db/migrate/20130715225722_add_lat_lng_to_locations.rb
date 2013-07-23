class AddLatLngToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :lat, :float
    add_column :locations, :lng, :float
  end
end
