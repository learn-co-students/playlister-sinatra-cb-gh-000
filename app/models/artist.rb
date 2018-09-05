class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, :through => :songs

  # extend Concerns::Slugifiable::ClassMethods
  # include Concerns::Slugifiable::InstanceMethods
  def slug
    self.name.downcase.gsub(' ', '-')
  end
  def self.find_by_slug(slug)
    Artist.all.find{ |instance| instance.slug == slug }
  end
end
