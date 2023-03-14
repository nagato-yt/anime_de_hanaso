class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :group_messages, dependent: :destroy
    
    belongs_to :user,optional: true
    
    validates :name, presence: true
    validates :introduction, presence: true
    
    
end
