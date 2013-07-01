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

    url = api_for(service)
    if method == 'post'
      payload[:token] = Profile.token
      BW::HTTP.post(url, {payload: payload}) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
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
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
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