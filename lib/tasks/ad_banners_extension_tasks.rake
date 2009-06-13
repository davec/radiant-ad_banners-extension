namespace :radiant do
  namespace :extensions do
    namespace :ad_banners do
      
      desc "Runs the migration of the Ad Banners extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          AdBannersExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          AdBannersExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Ad Banners to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from AdBannersExtension"
        Dir[AdBannersExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(AdBannersExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
