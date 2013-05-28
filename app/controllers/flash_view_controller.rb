class FlashViewController < UIViewController
  def viewDidLoad
    view.animationImages = ["kaiji-1.jpg".uiimage, "kaiji-2.jpg".uiimage, "kaiji-3.jpg".uiimage]
    view.animationDuration = 16.0
    view.animationRepeatCount = 100
    view.startAnimating
  end

  def touch
    view.stopAnimating
    self.performSegueWithIdentifier('pushHome', sender: self)
  end

  def touchesBegan(touches, withEvent:event)
    touch
  end
end