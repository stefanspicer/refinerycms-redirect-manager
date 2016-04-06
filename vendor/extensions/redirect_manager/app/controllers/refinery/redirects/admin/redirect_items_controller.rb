require 'will_paginate/array'

module Refinery
  module Redirects
    module Admin
      class RedirectItemsController < ::Refinery::AdminController

        crudify :'refinery/redirects/redirect_item',
                :title_attribute => 'src_path',
                :searchable => false,
                :sortable => false

        # NOTE: when making searchable: remember to add to your model `acts_as_indexed :fields => [:title, :body]`

        def index
          unless searching?
            find_all_redirect_items
          else
            search_all_redirect_items
          end

          @grouped_redirect_items = group_by_date(@redirect_items)

          @redirect_items = @redirect_items.paginate(page: params[:page])

          respond_to do |format|
            format.html
          end
        end

        private

        # Only allow a trusted parameter "white list" through.
        def redirect_item_params
          params.require(:redirect_item).permit(:src_path, :dest_url, :notes, :redirect_type)
        end
      end
    end
  end
end
