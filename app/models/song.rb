class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    special_chars = "!?$"

    slug = name
    slug.tr!(special_chars, "X")
    slug.tr!(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find { |song| song.slug == slug }
  end
end