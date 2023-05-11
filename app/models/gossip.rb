class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossip_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags

  validates :title,
    presence: true,
    length: { minimum: 3, maximum: 14}
  validates :content,
    presence: true
end
