class News < Nitron::Model
  #API_HOST = "http://192.168.1.30:3000"
  API_HOST = "http://localhost:3000"

  def self.all
    order('id')
  end

  def self.refresh
    unless App.delegate.network_reachable?
      p 'News: network UN-reachable'
      return
    end

    BW::HTTP.get("#{API_HOST}/api/news_list") do |response|
      if response.ok?
        self.all.to_a.each { |record| record.destroy }
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] != 0
          p 'News: status>0'
          return
        end
        json[:list].each { |record|
          data = {:title=>record[:title], :logo=>record[:logo], :link=>record[:link], :id=>record[:id] }
          News.create(data)
        }
      else
        p 'API not working'
      end
    end
  end

end