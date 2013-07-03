class TipsViewController < UIViewController
  FW_FILES = %w(
    fw-c1.jpg
    fw-c2.jpg
    fw-c3.jpg
    fw-c4.jpg
    fw-c5.jpg
    fw-c6.jpg
    fw-c7.jpg
    fw-c8.jpg
    fw-c9.jpg
    fw-m1.jpg
    fw-m2.jpg
    fw-m3.jpg
    fw-m4.jpg
    fw-m5.jpg
    fw-m6.jpg
    fw-m7.jpg
    fw-m8.jpg
    fw-m9.jpg
    fw-o1.jpg
    fw-o2.jpg
    fw-o3.jpg
    fw-o4.jpg
    fw-o5.jpg
    fw-o6.jpg
    fw-o7.jpg
    fw-o8.jpg
    fw-o9.jpg
  )

  def viewDidLoad
    @bounds = self.view.bounds
    @bounds.size.height -= 44   # dirty job, eh?

    view = ISPageScrollView.alloc.initWithFrame(self.view.bounds)
    view.dataSource = self
    view.numberOfPages = FW_FILES.size - 1  # buggy
    view.numberOfReusableViews = 5
    view.displayPage(0)
    self.view = view
  end


  def viewForScrollView(scroll, Page:index)
    v = UIView.alloc.initWithFrame @bounds

    img = UIImageView.alloc.initWithFrame(@bounds)
    img.contentMode = UIViewContentModeScaleToFill
    img.image = FW_FILES[index].uiimage
    v << img

    left = UIButton.buttonWithType(UIButtonTypeCustom)
    left.userInteractionEnabled = true
    left.setFrame [[0, 218], [23, 46]]
    left.setBackgroundImage('arrow-left'.uiimage, forState: UIControlStateNormal)
    left.when(UIControlEventTouchUpInside) do
      index = self.view.currentPage - 1
      index = FW_FILES.size - 1 if index < 0
      view.displayPage index
    end
    v << left

    right = UIButton.buttonWithType(UIButtonTypeCustom)
    right.userInteractionEnabled = true
    right.setFrame [[297, 218], [23, 46]]
    right.setBackgroundImage('arrow-right'.uiimage, forState: UIControlStateNormal)
    right.when(UIControlEventTouchUpInside) do
      index = self.view.currentPage + 1
      index = 0 if index > FW_FILES.size - 1
      view.displayPage index
    end
    v << right

    v
  end

end

#
#add property 'currentPage' to ISPageScrollView
#@property (nonatomic, readonly) NSInteger currentPage;
#
#which is set in last line of
#- (void)setupScrollViewForDisplayingPage:(NSInteger)pageIndex
#to take the value of pageIndex
# _currentPage = pageIndex;
