class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  
  # has_many :followers,
  #         class_name: 'Relationship',
  #         foreign_key: 'follower_id',
  #         dependent: :destroy,
  #         inverse_of: :follower
  # has_many :followings,
  #         class_name: 'Relationship',
  #         foreign_key: 'following_id',
  #         dependent: :destroy,
  #         inverse_of: :following
  # has_many :following_users, through: :followers, source: :following
  # has_many :follower_users, through: :followings, source: :follower
   has_many :relationships, dependent: :destroy
   has_many :followings, through: :relationships, source: :follower
  
   has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy 
   has_many :followers, through: :passive_relationships, source: :user 
  
  
  
  
    # def follow(other_user)
      # return if self == other_user
  
      # relationships.find_or_create_by!(follower: other_user)
    # end
    
    def follow(other_user_id)
      followers.create(following_id: other_user_id)
    end

    def following?(user)
      followings.include?(user)
    end

    def unfollow(relathinoship_id)
      relationships.find(relathinoship_id).destroy!
    end
  
  
end
