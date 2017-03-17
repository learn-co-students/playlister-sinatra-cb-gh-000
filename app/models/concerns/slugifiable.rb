module Concerns
  module Slugifiable
    module ClassMethods
      def find_by_slug(slug)
        where("replace(lower(name), '-', ' ') = ?", slug.split("-").join(" "))[0]
      end
    end

    module InstanceMethods
      def slug
        name.downcase.split(" ").join("-")
      end
    end
  end
end
