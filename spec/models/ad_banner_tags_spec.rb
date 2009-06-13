require File.dirname(__FILE__) + '/../spec_helper'

describe 'AdBanners' do
  dataset :pages

  before do
    %w( one two three ).each do |name|
      asset = Asset.create!(:title => name,
                            :asset_file_name => "#{name}.jpg",
                            :asset_content_type => 'image/jpeg',
                            :asset_file_size => 1234 + rand(1000))
      AdBanner.create!(:name => name,
                       :asset => asset,
                       :link_url => "http://www.#{name}.com",
                       :weight => 1,
                       :link_target => '')
    end
  end

  describe '<r:ad_banner> for a random banner' do

    it 'should return a link for a random banner' do
      tag = %{<r:ad_banner/>}
      expected = %r{<a href="http://www.(one|two|three).com"><img src="/assets/\d+/\1.jpg" title="\1" alt="\1" /></a>}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for a specific banner' do

    it 'should return a link for the specified banner' do
      tag = %{<r:ad_banner name="one"/>}
      expected = %r{<a href="http://www.one.com"><img src="/assets/\d+/one.jpg" title="one" alt="one" /></a>}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for a banner with no link' do

    before do
      asset = Asset.create!(:title => 'No Link',
                            :asset_file_name => "no_link.jpg",
                            :asset_content_type => 'image/jpeg',
                            :asset_file_size => 1234 + rand(1000))
      AdBanner.create!(:name => 'No Link',
                       :asset => asset,
                       :weight => 1,
                       :link_target => '')
    end

    it 'should return an IMG tag for the specified banner' do
      tag = %{<r:ad_banner name="No Link"/>}
      expected = %r{<img src="/assets/\d+/no_link.jpg" title="No Link" alt="No Link" />}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for a banner with encoded URL params' do

    before do
      asset = Asset.create!(:title => 'Deep Link',
                            :asset_file_name => "deep_link.jpg",
                            :asset_content_type => 'image/jpeg',
                            :asset_file_size => 1234 + rand(1000))
      AdBanner.create!(:name => 'Deep Link',
                       :asset => asset,
                       :link_url => 'http://deep-link.com/search?q=foo&bar=baz',
                       :weight => 1,
                       :link_target => '')
    end

    it 'should return a link with a properly encoded URL' do
      tag = %{<r:ad_banner name="Deep Link"/>}
      expected = %r{<a href="http://deep-link.com/search\?q=foo&amp;bar=baz"><img src="/assets/\d+/deep_link.jpg" title="Deep Link" alt="Deep Link" /></a>}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for four banners' do

    it 'should return three links for three different banners' do
      tag = %{<r:ad_banner/>} * 4
      expected = %r{(?:<a href="http://www.(one|two|three).com"><img src="/assets/\d+/\1.jpg" title="\1" alt="\1" /></a>){3}}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for one specific and three random banners' do

    it 'should return a link for the specified banner and a link for the two remaining banners' do
      tag = %{<r:ad_banner name="one"/>} + %{<r:ad_banner/>}*3
      expected = %r{<a href="http://www.one.com"><img src="/assets/\d+/one.jpg" title="one" alt="one" /></a>(?:<a href="http://www.(two|three).com"><img src="/assets/\d+/\1.jpg" title="\1" alt="\1" /></a>){2}}

      pages(:home).should render(tag).matching(expected)
    end

  end

  describe '<r:ad_banner> for a specific banner that does not exist' do

    it 'should return nothing' do
      tag = %{<r:ad_banner name="404"/>}
      expected = ''

      pages(:home).should render(tag).as(expected)
    end

  end

  describe '<r:ad_banner> when no banners exist' do

    before do
      AdBanner.delete_all
    end

    it 'should return nothing' do
      tag = %{<r:ad_banner/>}
      expected = ''

      pages(:home).should render(tag).as(expected)
    end

  end

end
