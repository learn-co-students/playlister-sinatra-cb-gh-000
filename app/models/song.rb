class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  # TODO - Build a method slug which takes a given song name and creates the "slugified" version.
end