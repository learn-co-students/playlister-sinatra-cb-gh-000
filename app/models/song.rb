class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  include Sluggable

  def add_genres_by_id genre_ids
    genre_ids.each do |id|
      self.genres << Genre.find(id.to_i)
    end
  end
end
