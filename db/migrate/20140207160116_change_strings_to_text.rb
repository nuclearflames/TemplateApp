class ChangeStringsToText < ActiveRecord::Migration
  def up
  	change_column :topics,	:description, :text
  	change_column :forums,	:description, :text
  	change_column :posts,	:description, :text
  	change_column :news,	:description, :text
  end

  def down
  	#Rollback propblems if db contains longer text's
  	change_column :topics,	:description, :string
  	change_column :forums,	:description, :string
  	change_column :posts,	:description, :string
  	change_column :news,	:description, :string
  end
end
