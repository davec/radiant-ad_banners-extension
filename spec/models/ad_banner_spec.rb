require File.dirname(__FILE__) + '/../spec_helper'

describe AdBanner do

  before(:each) do
    asset = Asset.create!(:title => 'Foo',
                          :caption => 'Bar',
                          :asset_file_name => 'asset.jpg',
                          :asset_content_type => 'image/jpeg',
                          :asset_file_size => 12345)
    @ad_banner = AdBanner.new(:name => 'Advertiser',
                              :asset => asset,
                              :link_url => 'http://www.example.com',
                              :weight => '1',
                              :link_target => '')
  end

  context 'validations' do

    it "should be valid" do
      @ad_banner.should be_valid
    end

    it 'should require a name' do
      @ad_banner.name = nil
      @ad_banner.should_not be_valid
      @ad_banner.errors.on(:name).should == I18n.t('activerecord.errors.messages.blank')
    end

    it 'should require an asset' do
      @ad_banner.asset = nil
      @ad_banner.should_not be_valid
      @ad_banner.errors.on(:asset_id).should == I18n.t('activerecord.errors.messages.blank')
    end

    it 'should not require a URL' do
      @ad_banner.link_url = nil
      @ad_banner.should be_valid
    end

    it 'should require a valid URL' do
      @ad_banner.link_url = 'example.com'
      @ad_banner.should_not be_valid
      @ad_banner.errors.on(:link_url).should == "doesn't look like a URL"
    end

  end

end
