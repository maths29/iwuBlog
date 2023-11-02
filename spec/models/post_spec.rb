require 'rails_helper'
RSpec.describe Post, type: :model do
  before :each do
    @user = User.new(name: 'John Doe')
  end
  it 'is valid with Title' do
    post = Post.new(author: @user, Title: 'Test Title')
    expect(post).to be_valid
  end
  it 'is not valid without Title' do
    post = Post.new(author: @user, Title: nil)
    expect(post).to_not be_valid
  end
  it 'is not valid if Title is greater than 250 characters' do
    post = Post.new(author: @user, Title: 'A' * 251)
    expect(post).to_not be_valid
  end
  it 'is not valid if comment counter is negative integer' do
    post = Post.new(author: @user, Title: 'New post', comments_counter: -2)
    expect(post).to_not be_valid
  end
  it 'is not valid if likes counter is negative integer' do
    post = Post.new(author: @user, Title: 'New post', likes_counter: -2)
    expect(post).to_not be_valid
  end
  it 'is valid if comment counter is zero' do
    post = Post.new(author: @user, Title: 'New Post', comments_counter: 0)
    expect(post).to be_valid
  end
  it 'is valid if like counter is zero' do
    post = Post.new(author: @user, Title: 'New Post', likes_counter: 0)
    expect(post).to be_valid
  end
  it 'is valid if comment counter is positive integer' do
    post = Post.new(author: @user, Title: 'New Post', comments_counter: 10)
    expect(post).to be_valid
  end
  it 'is valid if like counter is positive integer' do
    post = Post.new(author: @user, Title: 'New Post', likes_counter: 10)
    expect(post).to be_valid
  end
  it 'should have integer likes counter' do
    post = Post.new(author: @user, Title: 'New Post', likes_counter: 10)
    expect(post.likes_counter).to be_an_instance_of(Integer)
  end
  it 'should have integer comments counter' do
    post = Post.new(author: @user, Title: 'New Post', comments_counter: 10)
    expect(post.comments_counter).to be_an_instance_of(Integer)
  end
  context '.most_recent_comments should' do
    before :each do
      @post = Post.create(Title: 'Test Post', author: @user, created_at: 3.days.ago)
      @comment1 = Comment.create(post: @post, user: @user, text: 'old comment', created_at: 5.days.ago)
      @comment2 = Comment.create(post: @post, user: @user, text: '5th last comment', created_at: 4.days.ago)
      @comment3 = Comment.create(post: @post, user: @user, text: '4th last comment', created_at: 3.days.ago)
      @comment4 = Comment.create(post: @post, user: @user, text: '3rd last comment', created_at: 2.days.ago)
      @comment5 = Comment.create(post: @post, user: @user, text: '2ndlast comment', created_at: 1.days.ago)
      @comment6 = Comment.create(post: @post, user: @user, text: 'Most recent Comment', created_at: Time.current)
      @most_recent_comments = Post.most_recent_comments(@post)
    end
    it 'only returns 5 recent comments' do
      expect(@most_recent_comments).to contain_exactly(@comment2, @comment3, @comment4, @comment5, @comment6)
    end
    it 'not return older comment' do
      expect(@recent_posts).to_not contain_exactly(@comment1)
    end
    it 'return comment in decending order' do
      @most_recent_comments.each_cons(2) do |comment, next_comment|
        expect(comment.created_at).to be >= next_comment.created_at
      end
    end
  end
  context '.update_user_post_counter should' do
    it 'update post_counter of user' do
      Post.create(Title: 'First Post', author: @user)
      Post.create(Title: 'Second Post', author: @user)
      Post.create(Title: 'Third Post', author: @user)
      Post.create(Title: 'recent Post', author: @user)
      expect(@user.posts_counter).to equal(4)
    end
  end
end
