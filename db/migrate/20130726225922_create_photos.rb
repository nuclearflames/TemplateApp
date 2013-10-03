class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
        t.belongs_to    :user
        t.string        :title
        t.string        :description
        t.string        :type
        t.attachment    :picture

        t.timestamps
    end
  end
end
