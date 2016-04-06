module Refinery
  module Redirects
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Redirects

      engine_name :refinery_redirect_items

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "redirect_items"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.redirects_admin_redirect_items_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/redirects/redirect_items(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::RedirectItems)
      end
    end
  end
end