# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :likes, -> { order(created_at: :desc) }
  has_many :comments, -> { order(created_at: :desc) }

  validates :content, presence: true, length: { minimum: 10 }
  validates :user, presence: true
end
