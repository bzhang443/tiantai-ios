class FlashViewController < UIViewController
  def viewDidLoad
    # hide navigation bar
    # or make this view the first root view, then move the to storyboard, in AppDelegate
    # refer app_delegate+storeboard.rb in nitron.ui.extensions
    view.animationImages = ["kaiji-1.jpg".uiimage, "kaiji-2.jpg".uiimage, "kaiji-3.jpg".uiimage]
    view.animationDuration = 16.0
    view.animationRepeatCount = 100
    view.startAnimating
  end

  def touchesBegan(touches, withEvent:event)
    view.stopAnimating
    self.performSegueWithIdentifier('pushHome', sender: self)
  end
end