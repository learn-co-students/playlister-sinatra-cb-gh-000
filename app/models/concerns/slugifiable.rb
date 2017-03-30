module Concerns
  module Slugifiable
    module InstanceMethods
      def slug
        self.name.downcase.gsub(' ', '-')
      end
    end

    module ClassMethods
      def find_by_slug(slug)
        origin_name = slug.split("-").collect.with_index do |word, i|
          unless i != 0 && word.match(/\b(?:with|of|for|a|an|the)\b/)
            word.capitalize
          else
            word
          end
        end.join(" ")
        self.find_by(name: origin_name)
      end
    end
  end
end
