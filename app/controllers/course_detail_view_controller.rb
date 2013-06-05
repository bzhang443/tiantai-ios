class CourseDetailViewController < UIViewController
  attr_accessor :scroller
  def viewDidLoad
    self.scroller.contentSize = CGSizeMake(320, 800)
  end
end