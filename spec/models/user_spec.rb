require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Billy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Coder', posts_counter: 1323) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be Dodzi' do
    expect(subject.name).to eql 'Billy'
  end

  it 'photo should be valid' do
    expect(subject.photo).to eql 'https://unsplash.com/photos/F_-0BxGuVvo'
    expect(subject.photo).to be_a(String)
  end

  it 'bio should be valid' do
    expect(subject.bio).to eql 'Coder'
    expect(subject.bio).to be_a(String)
  end

  it 'posts counter should be present' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be valid' do
    expect(subject.posts_counter).to eql 1323
  end

  it 'posts counter should be integer' do
    expect(subject.posts_counter).to be_a(Integer)
    expect(subject).to be_valid
    subject.posts_counter = 3.14
    expect(subject).to_not be_valid
  end

  it 'posts counter should be greater than or equal to 0' do
    subject.posts_counter = -13
    expect(subject).to_not be_valid
  end

  it 'should return the 3 most recent posts for a given user' do
    expect(subject.recent_posts).to eq(subject.posts.order(created_at: :desc).limit(3))
  end
end
