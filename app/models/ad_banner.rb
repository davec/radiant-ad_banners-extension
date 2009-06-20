class AdBanner < ActiveRecord::Base
  order_by :name

  belongs_to :asset

  validates_presence_of :name, :asset_id#, :link_url
  validates_format_of :link_url, :allow_blank => true,
                      :with => /\Ahttps?:\/\/.+\z/,
                      :message => "doesn't look like a URL"

  def self.select_banner(options = {})
    exclusions = options[:exclude] || []
    weightings = find_by_sql("SELECT ad_banners.id,weight FROM ad_banners INNER JOIN assets ON assets.id = ad_banners.asset_id").map do |banner|
      [banner.id] * (exclusions.include?(banner.id) ? 0 : banner.weight)
    end.flatten
    find_by_id(weightings[rand(weightings.size)])
  end

end
