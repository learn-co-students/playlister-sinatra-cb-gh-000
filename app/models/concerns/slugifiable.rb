module Slugifiable
  module InstanceMethods
    def slug
      slug = name.downcase
      slug.gsub!(/[^0-9A-Za-z\s]/, '')
      slug.gsub!(/[\s]/, '-')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      all.find { |item| item.slug == slug }
    end
  end
end