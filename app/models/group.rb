class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :group_messages, dependent: :destroy
    
    has_one_attached :profile_image
    
    belongs_to :user,optional: true
    
    validates :name, presence: true,length: { in: 1..30 }
    validates :introduction, presence: true,length: { in: 1..200 }
    
    def get_profile_image
      (profile_image.attached?) ? profile_image : 'mizu.jpg'
    end
    
      def self.ransackable_attributes(auth_object = nil)
         ["created_at", "id", "introduction", "name", "owner_id", "updated_at"]
      end
end
