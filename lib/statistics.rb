require 'set'
require 'pp'

module Statistics
  
  def self.unique
    #Calculate the total numbers of unique users, per day, on facebook.com.
    
    puts "1) Calculating the total numbers of unique users, per day, on facebook.com."

    unique_visits = Set.new
    Visit.all.each do |visit| 
      if visit.site == 'facebook.com'
        meta = JSON.parse(visit.json)
        unique_visitors = meta.keys
        #puts "Unique users on facebook at #{visit.date}: #{unique_visitors.count}"
        Facebook.create(:date => visit.date, :unique_visits => unique_visitors.count)
      end
    end

  end

  def self.average

    # Calculate the per­day average number of seconds spent on Google properties (google.*)
    # between 20:00 and 23:00, by people that also have visited facebook.com.

    puts "2) Calculating the per­day average number of seconds spent on Google properties (google.*)\nbetween 20:00 and 23:00, by people that also have visited facebook.com."
    
    visitors = {}
    facebook_visitors = {}

    Spread.all.each do |spread|
      if spread.site == 'facebook.com'
        data = JSON.parse(spread.json)
        date = spread.date
        facebook_visitors[date] = data.keys
      end
    end

    Spread.all.each do |spread|
      if spread.site.match('google')
        data = JSON.parse(spread.json)
        date = spread.date
        visitors[date] = {}
        visitors[date][:users] = Set.new
        visitors[date][:n] = 0
        data.each do |user_id, info|
          visitors[date][:seconds] = 0 if visitors[date][:seconds] == nil
          info.each do |timeslice, values| 
            timeslice = timeslice.to_i
            if timeslice >= 79 and timeslice <= 91
              if facebook_visitors.include? user_id
                visitors[date][:seconds] += values[0]
                visitors[date][:n] += 1        
              end
            end
          end
        end
      end
    end

    visitors.each do |date, info|
      unless visitors[date][:seconds] == 0 or  visitors[date][:n] == 0
        visitors[date][:avg] =  visitors[date][:seconds]  / visitors[date][:n]
        puts "Average on #{date}: #{visitors[date][:avg]}"
      else
        visitors[date][:avg] = 0
      end
      Google.create(:date => date, :average => visitors[date][:avg])
    end
  end

  def self.deviation
    # Calculate the standard deviation of the amount of pageviews on facebook.com, based
    # on all data

    puts "3) Calculating the standard deviation of the amount of pageviews on facebook.com, based on all data"

    map = []
    sum = 0
    avg = 0
    n = 0

    Visit.all.each do |visit|
      if visit.site == 'facebook.com'
        data = JSON.parse(visit.json)
        data.each_key do |user_id|
          n += data[user_id].count
          data[user_id].each do |info|
            sum += info[1]
            map << info[1]
          end
        end
      end
    end

    Spread.all.each do |spread|
      if spread.site == 'facebook.com'
        data = JSON.parse(spread.json)
        data.each_key do |user_id|
          n += data[user_id].count
          data[user_id].each do |info|
            sum += info[1][1]
            map << info[1][1]
          end
        end
      end
    end

    avg = sum / n
    sum = 0

    map.each do |visits| 
      sum += Math::sqrt((visits - avg)**2)
    end

    dvn = (sum / n).round(2)

    Deviation.create(:result => dvn)

    #puts "Standart deviation of the amount of pageviews on facebook.com: #{dvn}"

  end

end