Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::Authentication::Devise::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-redirects').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::Authentication::Devise::User)

  if defined?(Refinery::Page)
    parent_identifier = "redirects-redirect_items"
    url               = "/redirects/redirect_items"
    page = Refinery::Page.where(identifier: parent_identifier).first_or_create!(
      :title => "Redirect Items",
      :identifier => parent_identifier,
      :deletable => false,
      :menu_match => "^#{url}(\/|\/.+?|)$"
    )
    Refinery::Pages.default_parts.each_with_index do |part, index|
      page.parts.where(:title => part).first_or_create!(:body => nil, :position => index)
    end
  end
end

