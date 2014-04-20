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

    has_attached_file :avatar, :styles => { :small => "100x100>", :thumb => "50x50" }, :default_url => "/assets/defaults/profile-default.jpg"

    validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/gif", "image/png"], :message => "File must be of type .png, .jpg, .gif"

    validates_attachment_size :avatar, :less_than => 1.megabyte, :message => "File must be smaller than 1 megabyte"

    # attr_accessible :title, :body

    validates_presence_of :alias, :email, :password, :password_confirmation, :on => :create, :message => "Alias, email, password and password confirmation required"

    validates_presence_of :alias, :email, :current_password, :on => :edit, :message => "Alias, email and verification password required"

    validates_uniqueness_of :alias, :message => "Alias already exists, please choose another"

    def avatar_url_thumb
        self.avatar.url(:thumb)
    end

    def avatar_url_medium
        self.avatar.url(:medium)
    end
end