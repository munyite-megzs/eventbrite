class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizer, class_name: "User"

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :attendances
  has_many :users, :through => :attendances

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

  def self.tagged_with(name)
    Tag.find_by!(:name).events
  end

  def self.tag_counts
    Tag.select("tags.name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id, tags.name")
  end

  def self.event_owner(organizer_id)
    User.find_by organizer_id
  end
end
