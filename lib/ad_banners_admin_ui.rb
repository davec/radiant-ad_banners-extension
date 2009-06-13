module AdBannersAdminUI

  def self.included(base)
    base.class_eval do

      attr_accessor :ad_banner
      alias_method :ad_banners, :ad_banner

      protected

        def load_default_ad_banner_regions
          returning OpenStruct.new do |ad_banner|
            ad_banner.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form assets_container}
              edit.bucket_pane.concat %w{bucket_notes bucket bucket_bottom}
              edit.asset_tabs.concat %w{bucket_tab}
            end
            ad_banner.new = ad_banner.edit
          end
        end

    end

  end
end
