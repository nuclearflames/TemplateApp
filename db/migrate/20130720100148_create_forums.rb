class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
        t.belongs_to    :user
        t.string        :name
        t.string        :description
        t.string        :title

        t.timestamps
    end
  end
end