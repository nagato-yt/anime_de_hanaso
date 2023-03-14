class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
    has_many :posts, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    # DM機能
    has_many :user_rooms, dependent: :destroy
    has_many :chats, dependent: :destroy
    has_many :rooms, through: :user_rooms
    # グループ機能
    has_many :group_users, dependent: :destroy
    has_many :groups, through: :group_users, dependent: :destroy
    has_many :owned_groups, class_name: "Group"
    

    # フォローをした、されたの関係
    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    
    # 一覧画面で使う
    has_many :followings, through: :relationships, source: :followed
    has_many :followers, through: :reverse_of_relationships, source: :follower
    
    #した
    def follow(user)
      relationships.create(followed_id: user.id)
    end
    
    #された
    def unfollow(user)
      relationships.find_by(followed_id: user.id).destroy
    end
    
    #判定
    def following?(user)
      followings.include?(user)
    end
         
   def self.guest
    find_or_create_by(email: 'dazai_osamu@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "太宰 治"
    end
   end
   
   def self.ransackable_attributes(auth_object = nil)
    ["email","name"]
   end
   
    def self.ransackable_associations(auth_object = nil)
    ["chats", "favorites", "followers", "followings", "post_comments", "posts", "relationships", "reverse_of_relationships", "rooms", "user_rooms"]
    end
  
  
end
