class User < ActiveRecord::Base
    has_one :location, dependent: :destroy
    has_many :forums, dependent: :destroy
    has_many :topics, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :photos, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :news, dependent: :destroy
    has_many :friends, dependent: :destroy
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :aboutme, :alias, :birthday, :avatar

    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/defaults/profile-default.jpg"

    # attr_accessible :title, :body

    validates_presence_of :alias, :email, :password, :password_confirmation, :on => :create

    validates_presence_of :alias, :email, :password_confirmation, :on => :edit

    validates_uniqueness_of :alias

    def avatar_url_thumb
        self.avatar.url(:thumb)
    end

    def avatar_url_meduim
        self.avatar.url(:medium)
    end
end