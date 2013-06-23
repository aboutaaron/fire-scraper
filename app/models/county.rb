class County < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  has_many :fires
end