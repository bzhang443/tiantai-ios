class TipsViewController < Nitron::ViewController
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
    super

    @bounds = self.view.bounds
    @bounds.size.height -= 44   # dirty job, eh?

    scroller.dataSource = self
    scroller.numberOfPages = FW_FILES.size - 1  # buggy
    scroller.numberOfReusableViews = 5
    scroller.displayPage 0
  end


  def viewForScrollView(scroll, Page:index)
    img = UIImageView.alloc.initWithFrame(@bounds)
    img.contentMode = UIViewContentModeScaleToFill
    img.image = FW_FILES[index].uiimage
    img
  end

  on :leftButton do
    index = scroller.currentPage - 1
    index = FW_FILES.size - 1 if index < 0
    scroller.displayPage index
  end

  on :rightButton do
    index = scroller.currentPage + 1
    index = 0 if index > FW_FILES.size - 1
    scroller.displayPage index
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
