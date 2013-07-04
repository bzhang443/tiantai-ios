class College < Nitron::Model

  def self.all
    order('title')
  end

  def self.refresh(&block)
    App.delegate.api_get('college_list') do |json|
      self.all.to_a.each { |record| record.destroy }
      json[:list].each do |record|
        data = {:title=>record[:title], :link=>record[:link]}
        College.create(data)
      end
      block.call if block
    end
  end

end