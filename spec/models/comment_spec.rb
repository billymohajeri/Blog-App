require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Billy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher', posts_counter: 8)
  post = Post.create(title: 'Resume', text: 'Lorem ipsum', comments_counter: 7, likes_counter: 3, author: user)
  subject { Comment.new(text: 'Hello everyone', author: user, post:) }

  before { subject.save }

  it 'comments counter should be 8' do
    expect(post.comments_counter).to eq 8
  end

  it 'should not valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'The comment should not be blank' do
    expect(subject).to be_valid
  end

  it 'The comment should not be blank' do
    expect(subject.text).to_not be_nil
  end

  it 'The author_id should be number' do
    subject.author_id = 'abc'
    expect(subject).to_not be_valid
  end

  it 'The author_id should be integer' do
    expect(subject.author_id).to be_a(Integer)
  end

  it 'The posts_id should be number' do
    subject.post_id = 'xyz'
    expect(subject).to_not be_valid
  end

  it 'The posts_id should be integer' do
    expect(subject.post_id).to be_a(Integer)
  end
end
