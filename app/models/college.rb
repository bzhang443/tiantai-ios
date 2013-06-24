class College < Nitron::Model
  #API_HOST = "http://192.168.1.30:3000"
  API_HOST = "http://localhost:3000"

  def self.all
    order('title')
  end

  def self.refresh
    unless App.delegate.network_reachable?
      p 'College: network UN-reachable'
      return
    end

    BW::HTTP.get("#{API_HOST}/api/college_list") do |response|
      if response.ok?
        self.all.to_a.each { |record| record.destroy }
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] != 0
          p 'College: status>0'
          return
        end
        json[:list].each { |record|
          data = {:title=>record[:title], :link=>record[:link]}
          College.create(data)
        }
      else
        p 'API not working'
      end
    end
  end

end