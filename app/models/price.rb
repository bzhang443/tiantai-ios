class Price < Nitron::Model
  attr_reader :member_holiday, :member_workday, :guest_workday, :guest_holiday

  def self.refresh(&block)
    App.delegate.api_get('price_list') do |json|
      self.all.to_a.each { |record| record.destroy }
      json[:list].each do |record|
        data = {:id=>record[:id], :name=>record[:name], :price=>"#{record[:price]}"}
        Price.create(data)
      end
      block.call if block
    end
  end

  NAMES = ['会员嘉宾平日价', '会员嘉宾假日价', '访客假日价', '访客平日价']
  def self.valid_price_names
    NAMES
  end

  def self.to_id(name)
    p = Price.find_by_name(name)
    return p.id
  end

  def member_workday
    p = Price.find_by_name(NAMES[0])
    return p.price if p
    puts "#{NAMES[0]} missing"
    '590*'
  end

  def member_holiday
    p = Price.find_by_name(NAMES[1])
    return p.price if p
    puts "#{NAMES[1]} missing"
    '890*'
  end

  def guest_holiday
    p = Price.find_by_name(NAMES[2])
    return p.price if p
    puts "#{NAMES[2]} missing"
    '1980*'
  end

  def guest_workday
    p = Price.find_by_name(NAMES[3])
    return p.price if p
    puts "#{NAMES[3]} missing"
    '1380*'
  end
end