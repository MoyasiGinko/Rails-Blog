class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id, dependent: :destroy
    has_many :likes, foreign_key: :author_id, dependent: :destroy
    has_many :coments, foreign_key: :author_id, dependent: :destroy
    
    validates :name, presence: true
    validates :photo, presence: true
    validates :bio, presence: true
    validates :post_counter, presence: true

    def recent_posts
        self.posts.order(created_at: :desc).limit(5)
    end
end
