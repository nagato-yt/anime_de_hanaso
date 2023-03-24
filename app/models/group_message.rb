class GroupMessage < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  
  validates :message,presence: true,length: { in: 1..200 }
end
