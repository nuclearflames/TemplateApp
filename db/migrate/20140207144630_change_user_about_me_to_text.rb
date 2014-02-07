class ChangeUserAboutMeToText < ActiveRecord::Migration
  def up
  	change_column :users,	:aboutme, :text
  end

  def down
  	#Rollback propblems if db contains longer text's
  	change_column :users,	:aboutme, :string
  end
end
