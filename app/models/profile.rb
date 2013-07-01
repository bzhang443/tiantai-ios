class Profile
  attr_accessor :name, :gender, :mobile, :company, :title, :handicap

  def self.token
    App::Persistence['token']
  end

  def self.load
    p = Profile.new
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

    data = {
            :name    => p.name,
            :gender  => p.gender,
            :mobile  => p.mobile,
            :company => p.company,
            :title   => p.title,
            :handicap=> p.handicap
    }
    App.delegate.api_post('user_config', data) do |body|
      puts 'user_config done'
    end
  end

  def self.device_signup
    return if App::Persistence['token']

    props = AppProperties.new
    device_model = 'iphone' if Device.iphone?
    device_model = 'ipad' if Device.ipad?
    device_model = 'simulator' if Device.simulator?
    device_model += '-retina' if Device.retina?
    device_model += "(#{Device.screen.width}x#{Device.screen.height})"
    data = {
        :did     => Device.identifierForVendor.UUIDString,
        :model   => device_model,
        :os      => Device.ios_version,
        :version => props.app_version,
        :source  => props.app_source
    }
    puts "device signup with did=#{data[:did]} and model=#{data[:model]}"

    BW::HTTP.post(App.delegate.api_for('sign_up'), {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] == 0
          App::Persistence['token'] = json[:token]
          puts "device token assigned: #{json[:token]}"
        end
      else
        App.alert '网络差劲，设备同步失败'
      end
    end
  end
end