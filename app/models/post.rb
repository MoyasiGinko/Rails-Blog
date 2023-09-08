class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :comments, foreign_key: :post_id, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  after_create :increment_post_counter
  before_destroy :decrement_post_counter

  before_destroy :delete_associated_comments_and_likes

  def delete_associated_comments_and_likes
    comments.destroy_all
    likes.destroy_all
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def increment_post_counter
    author.increment!(:posts_counter)
  end

  def decrement_post_counter
    author&.decrement!(:posts_counter)
  end
end
