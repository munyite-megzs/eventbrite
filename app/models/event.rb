class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizer, class_name: "User"

  has_many :taggings
  has_many :tags, through: :taggings

  def slug_candidates
    [
      :name,
      [:title, :location],
      [:title, :location, :agenda],
    ]
  end
end
