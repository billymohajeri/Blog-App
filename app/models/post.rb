class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  validates :Title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
