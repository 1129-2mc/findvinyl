class Shop < ApplicationRecord
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :place_id, presence: true

  has_many :shop_bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[address name postal_code]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
