class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
        t.belongs_to :user
        t.string    :location
        t.string    :city
        t.string    :town
        t.string    :street
        t.integer   :houseno
        t.string    :postcode

        t.timestamps
    end
  end
end
