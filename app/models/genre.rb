class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    special_chars = "!?$"

    slug = name.downcase
    slug.tr!(special_chars, "")
    slug.tr!(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find { |genre| genre.slug == slug }
  end
end