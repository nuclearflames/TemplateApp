class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
        t.belongs_to    :forum
        t.belongs_to    :user
        t.string        :title
        t.string        :description
        t.string        :category

        t.timestamps
    end
  end
end