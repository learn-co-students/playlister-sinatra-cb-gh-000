class Song < ActiveRecord::Base
  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods

  belongs_to :artist
  has_and_belongs_to_many :genres
end
