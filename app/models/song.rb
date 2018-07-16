class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, :through => :song_genres

  # extend Concerns::Slugifiable::ClassMethods
  # include Concerns::Slugifiable::InstanceMethods
  def slug
    self.name.downcase.gsub(' ', '-')
  end
  def self.find_by_slug(slug)
    Song.all.find{ |instance| instance.slug == slug }
  end
end
