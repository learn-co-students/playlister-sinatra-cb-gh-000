class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, though: :song_genres
end
