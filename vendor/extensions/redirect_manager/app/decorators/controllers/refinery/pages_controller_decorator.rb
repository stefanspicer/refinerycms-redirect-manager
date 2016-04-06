Refinery::PagesController.class_eval do
  def hook_before_404
    @page = ::Refinery::Page.where(:menu_match => "^/404$").includes(:parts).first
    redirect_item = Refinery::Redirects::RedirectItem.find_by_src_path(request.path)
    if redirect_item.present?
      redirect_to redirect_item.dest_url, status: redirect_item.permanent? ? 301 : 302
      return true
    end
    return false
  end
end
