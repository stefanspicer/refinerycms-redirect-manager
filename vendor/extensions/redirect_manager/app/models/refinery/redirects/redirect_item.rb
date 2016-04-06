module Refinery
  module Redirects
    class RedirectItem < Refinery::Core::BaseModel


      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      class << self
        def get_all
          order('position ASC')
        end

      end
    end
  end
end
