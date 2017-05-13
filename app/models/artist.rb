class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    special_chars = "!?$"

    slug = name
    slug.tr!(special_chars, "X")
    slug.tr!(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find { |artist| artist.slug == slug }
  end
end