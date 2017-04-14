module Sluggable
  def self.included base
    base.extend self::ClassMethods
    base.include self::InstanceMethods
  end

  module InstanceMethods
    def slug
      self.name.downcase.gsub(" ","-")
    end
  end

  module ClassMethods
    def find_by_slug slug
      self.all.detect{|instance| instance.slug == slug}
    end
  end
end
