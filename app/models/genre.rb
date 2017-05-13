class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  # TODO - Build a method slug which takes a given genre name and creates the "slugified" version.
end