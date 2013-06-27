class Profile
  attr_accessor :token, :name, :gender, :mobile, :company, :title, :handicap

  def self.load
    p = Profile.new
    p.token    = App::Persistence['token']
    p.name     = App::Persistence['name']
    p.gender   = App::Persistence['gender']
    p.mobile   = App::Persistence['mobile']
    p.company  = App::Persistence['company']
    p.title    = App::Persistence['title']
    p.handicap = App::Persistence['handicap']
    p
  end

  def self.save(p)
    App::Persistence['name']     = p.name     if p.name
    App::Persistence['gender']   = p.gender   if p.gender
    App::Persistence['mobile']   = p.mobile   if p.mobile
    App::Persistence['company']  = p.company  if p.company
    App::Persistence['title']    = p.title    if p.title
    App::Persistence['handicap'] = p.handicap if p.handicap

    #App.delegate.api_call('post', 'user_config', data) {}

    unless App.delegate.network_reachable?
      App.delegate.network_error_report
      return
    end
    data = {:token=> App::Persistence['token'],
            :name=>p.name,
            :gender=>p.gender,
            :mobile=>p.mobile,
            :company=>p.company,
            :title=>p.title,
            :handicap=>p.handicap
    }
    BW::HTTP.post(App.delegate.api_for('user_config'), {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] != 0
          App.alert json[:message]
          return
        end
      else
        App.delegate.api_error_report
      end
    end
  end

  def self.setup(token)
    App::Persistence['token'] = token if token
    puts "Profile setup with token=#{token}"
  end

  def self.device_signup
    return unless App::Persistence['token'].nil?
    unless App.delegate.network_reachable?
      App.delegate.network_error_report
      return
    end
    device_model = 'iphone' if Device.iphone?
    device_model = 'ipad' if Device.ipad?
    device_model = 'simulator' if Device.simulator?
    device_model += '-retina' if Device.retina?
    device_model += "(#{Device.screen.width}x#{Device.screen.height})"
    data = {:did=>BubbleWrap.create_uuid, :model=>device_model, :os=>Device.ios_version, :version=>'1.0', :source=>'AppStore'}
    #puts "device signup with did=#{data[:did]} and model=#{data[:model]}"
    BW::HTTP.post(App.delegate.api_for('sign_up'), {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] != 0
          App.alert json[:message]
          return
        end
        Profile.setup(json[:token])
      else
        App.delegate.api_error_report
      end
    end
  end
end