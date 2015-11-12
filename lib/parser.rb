require 'json'

module Parser

  def parse(path)
    data = File.open(path)
    parsed = []

    while((line = data.gets) != nil) 
      site, date, meta =  line.split("\t").map(&:strip)
      while((line = data.gets.strip) != '"') 
        meta += line
      end
      json = Decryptor::normalize(meta)
      parsed << { :site => site, :date => date, :json  => json + "\n" }
      # puts "site: #{site}, date: #{date}"
    end
    parsed
  end

  def data(path)
    data = parse(path)
    data
  end

end