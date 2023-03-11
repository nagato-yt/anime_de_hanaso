class Post < ApplicationRecord
    belongs_to :user,optional: true
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    
    has_and_belongs_to_many :hashtags
    
    after_create do 
        post = Post.find_by(id: self.id)
        hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        hashtags.uniq.map do |hashtag|
            tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
            post.hashtags << tag
        end
    end
    
    before_update do 
        post = Post.find_by(id: self.id)
        post.hashtags.clear
        hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        hashtags.uniq.map do |hashtag|
            tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
            post.hashtags << tag
        end
    end
    
    def favorited_by?(user)
         favorites.exists?(user_id: user.id)
    end
end
