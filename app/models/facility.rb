class Facility < Nitron::Model

  def self.all
    order('title')
  end

  def self.refresh(&block)
    App.delegate.api_get('facility_list') do |json|
      self.all.to_a.each { |record| record.destroy }
      json[:list].each { |record|
        data = {:title=>record[:title], :logo=>record[:logo], :link=>record[:link], :intro=>record[:intro] }
        Facility.create(data)
      }
      block.call if block
    end
  end

end