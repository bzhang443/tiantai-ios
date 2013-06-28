module NetworkHelper
  def api_post(service, payload, &handler)
    api_call(service, 'post', payload, &handler)
  end

  def api_get(service, &handler)
    api_call(service, 'get', nil, &handler)
  end

  def api_for(service)
    "http://125.208.5.139:3000/api/#{service}"
  end

  def api_call(service, method, payload, &handler)
    unless App.delegate.network_reachable?
      App.alert '网络差劲，请稍后再试'
      return
    end

    #token = Profile.device_token
    #unless token
    #  puts 'token not saved yet?'
    #  App.alert '设备注册失败，请稍后再试'
    #  #return
    #end

    puts "api_call with service=#{service}, method=#{method}, payload=#{payload}, handler=#{handler}"
    url = api_for(service)
    if method == 'post'
      BW::HTTP.post(url, {payload: payload}) do |response|
#        puts "http response_code: #{response.status_code}"
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
#          puts "json=#{json}"
          if json[:status] != 0
            App.alert json[:message]
            return
          end
          handler.call(json)
        else
          App.alert '服务器故障，请稍后再试'
        end
      end
    elsif method == 'get'
      BW::HTTP.get(url) do |response|
        #puts "http response_code: #{response.status_code}"
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          #puts "json=#{json}"
          if json[:status] != 0
            App.alert json[:message]
            return
          end
          puts 'handler not available!!!!' unless handler
          handler.call(json) if handler
        else
          App.alert '服务器故障，请稍后再试'
        end
      end
    else
      puts "unsupported #{method}"
    end
  end

end