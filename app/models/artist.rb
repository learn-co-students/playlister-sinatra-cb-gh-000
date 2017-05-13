class Artist < ActiveRecord::Base
  has_many :songs
  has_many :song_genres, through: :songs
  has_many :genres, through: :song_genres

  def slug
    special_chars = "!?$"

    slug = name.downcase
    slug.tr!(special_chars, "")
    slug.tr!(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find { |artist| artist.slug == slug }
  end
end