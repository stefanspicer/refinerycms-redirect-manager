module Refinery
  module Redirects
    class RedirectItemsController < ::ApplicationController

      before_action :find_all_redirect_items
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @redirect_item in the line below:
        present(@page)
      end

      def show
        @redirect_item = RedirectItem.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @redirect_item in the line below:
        present(@page)
      end

    protected

      def find_all_redirect_items
        @redirect_items = RedirectItem.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/redirect_items").first
      end

    private

      def redirect_item_params
        params.require(:redirect_item).permit(:src_path, :dest_url, :notes, :redirect_type)
      end

    end
  end
end
