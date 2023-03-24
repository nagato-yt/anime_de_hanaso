class Post < ApplicationRecord
    belongs_to :user,optional: true
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :post_tag_relations, dependent: :destroy
    has_many :tags, through: :post_tag_relations, dependent: :destroy
    
    
    validates :title,presence: true, length: { in: 1..50 }
    validates :body,presence: true, length: { in: 1..200 }
    
    def favorited_by?(user)
         favorites.exists?(user_id: user.id)
    end
    
    # ransack
      def self.ransackable_attributes(auth_object = nil)
          ["body", "created_at", "id", "title", "updated_at", "user_id"]
      end
end
