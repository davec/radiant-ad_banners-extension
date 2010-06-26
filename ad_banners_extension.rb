# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AdBannersExtension < Radiant::Extension
  version "0.1"
  description "Manage ad banners"
  url "http://github.com/davec/radiant-ad_banners-extension"
 
  def activate
    Radiant::AdminUI.send :include, AdBannersAdminUI unless defined? admin.ad_banner
    admin.ad_banner = Radiant::AdminUI.load_default_ad_banner_regions

    tab "Content" do
      add_item "Ads", "/admin/ad_banners", :after => "Pages"
    end
    Page.send :include, AdBannerTags
  end
 
end
