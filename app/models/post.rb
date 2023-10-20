class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  after_create :increment_post_counter

  private

  def increment_post_counter
    author.increment!(:post_counter)
  end
end
