class WeddingViewController < UIViewController
  attr_accessor :scroller
  def viewDidLoad
    self.scroller.contentSize = CGSizeMake(320, 2600)
  end
end