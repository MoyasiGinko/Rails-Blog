class Coment < ApplicationRecord
    belongs_to :author, class_name: 'User' , foreign_key: :author_id, dependent: :destroy
    belongs_to :post, class_name: 'Post'  , foreign_key: :post_id, dependent: :destroy
    
    validates :author_id, presence: true
    validates :post_id, presence: true
    after_create :increase_comments_counter

    def increase_comments_counter
        self.post.comments_counter += 1
        self.post.save
    end
end
