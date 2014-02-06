class User < ActiveRecord::Base
  has_one :location, dependent: :destroy
  has_many :forums, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :news, dependent: :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :aboutme, :alias, :birthday, :avatar

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  # attr_accessible :title, :body

  validates_presence_of :alias, :email, :password, :password_confirmation

  validates_uniqueness_of :alias
end