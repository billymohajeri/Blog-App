require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(title: 'First post', text: 'Better post', comments_counter: 191, likes_counter: 8791, author_id: 1)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be First post' do
    expect(subject.title).to eql 'First post'
  end

  it 'title should be maximum 250 words' do
    subject.title = 'c' * 251
    expect(subject).to_not be_valid
  end

  it 'text should be Better post' do
    expect(subject.text).to eql 'Better post'
  end

  it 'comments counter should be present' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter should be valid' do
    expect(subject.comments_counter).to eql 191
  end

  it 'comments counter should be greater than or equal to 0' do
    subject.comments_counter = -18
    expect(subject).to_not be_valid
  end

  it 'comments counter should be integer' do
    subject.comments_counter = 3.14
    expect(subject).to_not be_valid
  end

  it 'likes counter should be present' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes counter should be valid' do
    expect(subject.likes_counter).to eql 8791
  end

  it 'likes counter should be greater than or equal to 0' do
    subject.likes_counter = -1930
    expect(subject).to_not be_valid
  end

  it 'likes counter should be integer' do
    subject.likes_counter = 3.1415
    expect(subject).to_not be_valid
  end

  it 'should return the 5 most recent comments for a given post' do
    expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
