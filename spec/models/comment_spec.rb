require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create(name: 'marry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from Spain.') }
  
  let!(:post) { Post.create(Title: 'hello world', text: 'Hello world paragraph', author: user, comments_counter:0, likes_counter:0) }
  
  subject(:comment) { Comment.new(user:user, post:post, text: 'this  is my comment') }
  before { comment.save }

  it 'should be valid comment' do
    expect(comment).to be_valid
  end
  it 'comment should match' do
    expect(comment.text).to eq 'this  is my comment'
  end
  it 'post comment should be update on comment save' do
    post.reload
    expect(post.comments.size).to eq(1)
  end
  it 'comment user id should be same' do
    expect(comment.user.id).to be(user.id)
  end
  it 'comment post id should be same' do
    expect(comment.post.id).to be(post.id)
  end
  it 'should be invalid on negetive comment counter' do
    comment.post.comments_counter = -1
    expect(comment.post).to_not be_valid
  end
  it 'should be invalid on non negetive comment counter' do
    comment.post.comments_counter = 'test'
    expect(comment.post).to_not be_valid
  end
end
