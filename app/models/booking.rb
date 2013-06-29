class Booking < Nitron::Model

  def self.add(data, &callback)
    App.delegate.api_post('booking_add', data) do |json|
      callback.call if callback
    end
  end

  def self.delete(order_id, &callback)
    data = {:order_id => order_id}
    App.delegate.api_post('booking_delete', data) do |json|
      record = Booking.find_by_order_id(order_id)
      record.destroy
      callback.call if callback
    end
  end

  def self.all
    order('order_id')
  end

  def self.refresh
    App.delegate.api_get("booking_history?token=#{Profile.token}") do |json|
      self.all.to_a.each { |record| record.destroy }
      json[:list].each { |record|
        data = {:order_id   => record[:order_id],
                :price_name => record[:price_name],
                :name       => record[:name],
                :date       => record[:date],
                :mobile     => record[:mobile],
                :friends    => record[:friends],
                :status     => record[:status]||'处理中',
                :memo       => record[:memo]
        }
        Booking.create(data)
      }
    end
  end

  def friends
    primitiveValueForKey(:friends).stringValue
  end
end