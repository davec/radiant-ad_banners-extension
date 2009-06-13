# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AdBannersExtension < Radiant::Extension
  version "0.1"
  description "Manage ad banners"
  url "http://yourwebsite.com/ad_banners"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :ad_banners
    end
  end
  
  def activate
    Radiant::AdminUI.send :include, AdBannersAdminUI unless defined? admin.ad_banner
    admin.ad_banner = Radiant::AdminUI.load_default_ad_banner_regions

    admin.tabs.add "Ads", "/admin/ad_banners", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
  end
  
end
