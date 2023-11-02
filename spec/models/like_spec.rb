require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { User.create(name: 'Kidshan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer from potland.') }

  let!(:post) do
    Post.create(Title: 'hello world', text: 'Hello world paragraph', author: user, likes_counter: 0,
                comments_counter: 0)
  end

  subject(:like) { Like.new(user:, post:) }
  before { like.save }
  it 'should be valid like' do
    expect(like).to be_valid
  end
  it 'post like count should be 1' do
    expect(like.post.likes.size).to be(1)
  end
  it 'user like count should be 1' do
    expect(like.user.likes.size).to be(1)
  end
  it 'should be invalid on negetive like counter' do
    like.post.likes_counter = -1
    expect(like.post).to_not be_valid
  end
  it 'should not be valid for non integer like counter' do
    like.post.likes_counter = 'dd'
    expect(like.post).to_not be_valid
  end
end
