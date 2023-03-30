require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like Model Test' do
    subject { Like.new(author_id: 3, post_id: 2) }
    before { subject.save }

    it 'The author_id should be number' do
      expect(subject).to be_valid
    end

    it 'The author_id should be an integer' do
      expect(subject.author_id).to be_a(Integer)
    end

    it 'The author_id should be 3' do
      expect(subject.author_id).to be == 3
    end

    it 'The post_id should be number' do
      subject.post_id = 'xyz'
      expect(subject).to_not be_valid
    end

    it 'The post_id should be 2' do
      expect(subject.post_id).to be == 2
    end

    it 'The post_id should be an integer' do
      expect(subject.post_id).to be_a(Integer)
    end
  end
end
