class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
    has_many :posts, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    

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
end
