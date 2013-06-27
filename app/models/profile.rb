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
    App::Persistence['token']    = p.token    if p.token
    App::Persistence['name']     = p.name     if p.name
    App::Persistence['gender']   = p.gender   if p.gender
    App::Persistence['mobile']   = p.mobile   if p.mobile
    App::Persistence['company']  = p.company  if p.company
    App::Persistence['title']    = p.title    if p.title
    App::Persistence['handicap'] = p.handicap if p.handicap
  end

  def self.exist?
    ! App::Persistence['token'].nil?
  end

  def gender
    @gender || '男'
  end
end