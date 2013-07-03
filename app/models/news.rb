class News < Nitron::Model
  #attr_accessor :ui_delegate

  def self.all
    order('id', ascending: false)
  end

  def self.refresh
    App.delegate.api_get('news_list') do |json|
      self.all.to_a.each { |record| record.destroy }
      json[:list].each { |record|
        data = {:title=>record[:title], :logo=>record[:logo], :link=>record[:link], :id=>record[:id] }
        News.create(data)
      }
    end
  end

end