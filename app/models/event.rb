class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :organizer, class_name: "User"

  def slug_candidates
    [
      :name,
      [:title, :location],
      [:title, :location, :agenda],
    ]
  end
end
