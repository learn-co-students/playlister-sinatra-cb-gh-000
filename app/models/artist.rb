class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    special_chars = "!?$"

    slug = self.name
    slug.tr!(special_chars, "X")
    slug.tr!(" ", "-")
  end
end