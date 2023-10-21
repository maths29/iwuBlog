class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  validates :Title, presence: true, length: { maximum: 250 }
  validates :likes_count, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_count, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_counter

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  after_create :increment_post_counter

  private

  def increment_post_counter
    author.increment!(:post_counter)
  end
end
