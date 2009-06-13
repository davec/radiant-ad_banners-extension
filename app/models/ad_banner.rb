class AdBanner < ActiveRecord::Base
  default_scope :order => 'name ASC'

  belongs_to :asset

  validates_presence_of :name, :asset_id#, :link_url
  validates_format_of :link_url, :allow_blank => true,
                      :with => /\Ahttps?:\/\/.+\z/,
                      :message => "doesn't look like a URL"
end
