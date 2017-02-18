class Genre < ActiveRecord::Base
  has_and_belongs_to_many :songs
  has_many :artists, through: :songs

  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods
end