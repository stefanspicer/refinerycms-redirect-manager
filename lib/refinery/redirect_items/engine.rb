module Refinery
  module Redirects
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Redirects

      engine_name :refinery_redirect_manager

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "redirect_manager"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.redirects_admin_redirect_items_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/redirects/redirect_items(/.*)?$}
          plugin.position = 80
          plugin.icon = 'icon icon-sitemap'
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::RedirectItems)
      end
    end
  end
end
