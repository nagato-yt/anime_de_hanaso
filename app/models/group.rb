class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :group_messages, dependent: :destroy
    
    has_one_attached :profile_image
    
    belongs_to :user,optional: true
    
    validates :name, presence: true
    validates :introduction, presence: true
    
    def get_profile_image
      (profile_image.attached?) ? profile_image : 'mizu.jpg'
    end
end
