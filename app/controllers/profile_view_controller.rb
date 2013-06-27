class ProfileViewController <  Nitron::ViewController
  attr_accessor :delegate

  def viewDidLoad
    super
    if self.model.gender == '女'
      maleButton.setImage('profile-male-off.jpg'.uiimage, forState: UIControlStateNormal)
      femaleButton.setImage('profile-female.jpg'.uiimage, forState: UIControlStateNormal)
    end
  end

  on :save do
    profile = Profile.new
    profile.name = nameField.text
    profile.mobile = mobileField.text
    profile.company = companyField.text
    profile.title = titleField.text
    profile.handicap = handicapField.text
    profile.gender = self.model.gender
    Profile.save(profile)
    self.delegate.on_profile_changed(profile)
    UIAlertView.alert "个人信息保存成功" { self.navigationController.popViewControllerAnimated(false) }
  end

  on :maleButton do
    maleButton.setImage('profile-male.jpg'.uiimage, forState: UIControlStateNormal)
    femaleButton.setImage('profile-female-off.jpg'.uiimage, forState: UIControlStateNormal)
    self.model.gender = '男'
  end

  on :femaleButton do
    maleButton.setImage('profile-male-off.jpg'.uiimage, forState: UIControlStateNormal)
    femaleButton.setImage('profile-female.jpg'.uiimage, forState: UIControlStateNormal)
    self.model.gender = '女'
  end
end