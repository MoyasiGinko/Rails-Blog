class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, dependent: :destroy
  has_many :coments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :text, presence: true

  after_create :increment_post_counter
  before_destroy :decrement_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def increment_post_counter
    author.increment!(:posts_counter)
  end

  def decrement_post_counter
    author.decrement!(:posts_counter)
  end
end
