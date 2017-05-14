module Slugifiable
  module InstanceMethods
    def slug
      special_chars = "!?$!@#%^&*()[]{}"

      slug = name.downcase
      slug.tr!(special_chars, "")
      slug.tr!(" ", "-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      all.find { |item| item.slug == slug }
    end
  end
end