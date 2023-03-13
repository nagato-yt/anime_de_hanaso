class Group < ApplicationRecord
    has_many :group_users
    has_many :users, through: :group_userss
    
    validates :name, presence: true
    validates :introduction, presence: true
end
