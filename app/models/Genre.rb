class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, though: :song_genres
end