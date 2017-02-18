class Song < ActiveRecord::Base
  belongs_to :artist
  has_and_belongs_to_many :genres

  include Concerns::Slugifiable::InstanceMethods
  extend Concerns::Slugifiable::ClassMethods
end