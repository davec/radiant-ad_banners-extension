module AdBannerTags
  include Radiant::Taggable

  require 'rexml/document'

  tag 'ad_banner' do |tag|
    @selected_banners ||= []
    ad_banner = tag.attr['name'] ? AdBanner.find_by_name(tag.attr['name']) : AdBanner.select_banner(:exclude => @selected_banners)
    unless ad_banner.nil?
      @selected_banners << ad_banner.id
      # The HTML is simple enough to roll by hand instead of sucking in REXML
      returning String.new do |result|
        if ad_banner.link_url
          result << %Q{<a href="#{CGI.escapeHTML(ad_banner.link_url)}"}
          result << %Q{ target="#{ad_banner.link_target}"} unless ad_banner.link_target.blank?
          result << '>'
        end
        result << %Q{<img src="#{ad_banner.asset.thumbnail(:original)}" title="#{ad_banner.name}" alt="#{ad_banner.asset.caption || ad_banner.asset.title}" />}
        result << '</a>' if ad_banner.link_url
      end
    end
  end

end
