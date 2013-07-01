class CourseDetailViewController < UIViewController
  attr_accessor :scroller
  def viewDidLoad
    self.scroller.contentSize = CGSizeMake(320, 1200)
  end
end