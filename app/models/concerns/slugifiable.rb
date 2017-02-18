module Concerns

  module Slugifiable
    module InstanceMethods
      def slug
        self.name.downcase.split(' ').join('-')
      end
    end
    module ClassMethods
      def find_by_slug(slug)
        self.where("replace(lower(name), '-', ' ')  = ?", slug.split('-').join(' '))[0]
      end
    end
  end

end