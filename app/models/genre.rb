class Genre < ActiveRecord::Base
  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods

  has_and_belongs_to_many :songs
  has_many :artists, through: :songs
end
