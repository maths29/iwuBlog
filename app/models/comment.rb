class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comment_counter

  private

  def update_comment_counter
    post.increment!(Comments_Counter: post.comments.count)
  end
end
