class CreateRedirectsRedirectItems < ActiveRecord::Migration

  def up
    create_table :refinery_redirects_redirect_items do |t|
      t.string :src_path
      t.string :dest_url
      t.string :notes
      t.integer :redirect_type
      t.integer :position
      
      t.timestamps
    end

    add_index ::Refinery::Redirects::RedirectItem.table_name, :id


  end



  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-redirects"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/redirects/redirect_items"})
    end

    drop_table :refinery_redirects_redirect_items

  end

end
