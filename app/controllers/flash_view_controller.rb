class FlashViewController < UIViewController
  #attr_accessor :window

  def viewDidLoad
    view = UIImageView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    view.animationImages = ['kaiji-1.jpg'.uiimage, 'kaiji-2.jpg'.uiimage, 'kaiji-3.jpg'.uiimage]
    view.animationDuration = 16.0
    view.animationRepeatCount = 100
    view.startAnimating
    self.view = view
  end

  def touchesBegan(touches, withEvent:event)
    p "touchesBegin"
    self.view.stopAnimating
    #@window.tell_story
  end

  #def tell_story
  #  @window.rootViewController = storyboard.instantiateInitialViewController
  #end
end