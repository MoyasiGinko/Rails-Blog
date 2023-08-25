class Post < ApplicationRecord
  belongs_to :author , class_name: "User" , foreign_key: :author_id , dependent: :destroy
  has_many :likes, dependent: :destroy 
  has_many :coments, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  validates :comments_counter, presence: true
  validates :likes_counter, presence: true

  after_create :increase_posts_counter

  def recent_comments
    self.coments.order(created_at: :desc).limit(5)
  end

  def increase_posts_counter
    self.post_counter += 1
    self.save
  end
end
