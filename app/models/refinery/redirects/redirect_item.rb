module Refinery
  module Redirects
    class RedirectItem < Refinery::Core::BaseModel

      TYPES = [:temporary, :permanent]
      enum redirect_type: TYPES

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      acts_as_indexed :fields => [:notes, :src_path, :dest_url]

      class << self
        def get_all
          order('position ASC')
        end

      end
    end
  end
end
