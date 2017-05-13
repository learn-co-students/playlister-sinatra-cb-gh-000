class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
  
  # TODO - Build a method slug which takes a given artist name and creates the "slugified" version.
end