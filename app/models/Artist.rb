class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
  extend Concerns::Slugifiable::ClassMethods
  include Concerns::Slugifiable::InstanceMethods
end
