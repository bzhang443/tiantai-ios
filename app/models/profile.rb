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

    data = {
            :token   => App::Persistence['token'],
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

  def self.device_token
    token = App::Persistence['token']
    return token if token

    device_model = 'iphone' if Device.iphone?
    device_model = 'ipad' if Device.ipad?
    device_model = 'simulator' if Device.simulator?
    device_model += '-retina' if Device.retina?
    device_model += "(#{Device.screen.width}x#{Device.screen.height})"
    data = {:did=>BubbleWrap.create_uuid, :model=>device_model, :os=>Device.ios_version, :version=>'1.0', :source=>'AppStore'}
    puts "device signup with did=#{data[:did]} and model=#{data[:model]}"

    BW::HTTP.post(App.delegate.api_for('sign_up'), {payload: data}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        if json[:status] == 0
          token = json[:token]
          App::Persistence['token'] = token
          puts "device token assigned: #{token}"
        end
      end
    end

    App::Persistence['token']
  end
end