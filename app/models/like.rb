class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  validates :author, presence: true
  validates :post, presence: true

  after_create :increase_likes_counter

  def increase_likes_counter
    post.increment(:likes_counter).save
  end
end
