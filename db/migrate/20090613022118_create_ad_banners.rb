class CreateAdBanners < ActiveRecord::Migration
  def self.up
    create_table :ad_banners do |t|
      t.string :name
      t.string :link_url
      t.string :link_target
      t.integer :asset_id
      t.integer :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :ad_banners
  end
end
