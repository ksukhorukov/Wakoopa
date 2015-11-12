require './app_helper.rb'

namespace :db do 
  desc "Run database migrations"
  task :migrate do 
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end

namespace :data do
  desc "Parse all data and store it in database"
  task :parse do 
    puts "[i] Parsing data. This can take a few minutes..."
    spread = SpreadParser::data('./data/domain_spread_cache')
    visits = VisitsParser::data('./data/domain_visits_cache')
    spread.each do |info| 
      Spread.create!(:site => info[:site], :date => info[:date], :json => info[:json])
    end
    visits.each do |info|
      Visit.create!(:site => info[:site], :date => info[:date], :json => info[:json])
    end
  end
end

namespace :statistics do 
  desc "Calculate statistics base on parsed data"
  task :calc do 
    Statistics::unique
    Statistics::average
    Statistics::deviation
  end
end

