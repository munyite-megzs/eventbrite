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

  def all_tags=(names)
    self.tags = names.split(",").map do |t|
      Tag.where(name: t.split).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
