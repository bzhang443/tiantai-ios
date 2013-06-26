class College < Nitron::Model

  def self.all
    order('title')
  end

  def self.refresh
    unless App.delegate.network_reachable?
      App.delegate.network_error_report
      return
    end

    BW::HTTP.get(App.delegate.api_for('college_list')) do |response|
      if response.ok?
        self.all.to_a.each { |record| record.destroy }
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] != 0
          App.alert json[:message]
          return
        end
        json[:list].each { |record|
          data = {:title=>record[:title], :link=>record[:link]}
          College.create(data)
        }
      else
        App.delegate.api_error_report
      end
    end
  end

end