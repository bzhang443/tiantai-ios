class SettingViewController < Nitron::ViewController
  def viewDidLoad
    super
    self.model = Profile.load
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == 'EditProfile'
      vc = segue.destinationViewController
      vc.model = self.model
      vc.delegate = self
    end
  end

  def on_profile_changed(profile)
    self.model = profile
  end

end