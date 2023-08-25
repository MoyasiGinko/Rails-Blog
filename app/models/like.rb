class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post , class_name: 'Post'

  validates :author, presence: true
  validates :post, presence: true

  after_create :increase_likes_counter
  
  def increase_likes_counter
    self.post.likes_counter += 1
    self.post.save
  end
end
