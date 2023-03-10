class Relationship < ApplicationRecord
    
    belongs_to :follower, class_name: "User"#された
    belongs_to :followed, class_name: "User"#した
end
