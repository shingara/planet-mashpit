# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
 
use_orm :datamapper
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '69e198399d7b627efd6d2c525e3120eba02d6e0a'  # required for cookie session store
  c[:session_id_key] = '_planet-merb_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  Merb::Cache.setup do
    register(:page_store, Merb::Cache::PageStore[Merb::Cache::FileStore], :dir => Merb.root / "public")
    register(:default, Merb::Cache::AdhocStore[:page_store])
  end

end
