class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods

end