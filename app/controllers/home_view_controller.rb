class HomeViewController < UIViewController

  def viewDidLoad
    self.navigationController.navigationBar.setBackgroundImage('top.png'.uiimage, forBarMetrics:UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setBackButtonBackgroundImage('navi_back.png'.uiimage, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setTitle('返回')
  end

 # (main)> tree
 # 0: . UIWindow(#b094a50, [[0.0, 0.0], [320.0, 568.0]])
 # 1: `-- UILayoutContainerView(#b099d10, [[0.0, 0.0], [320.0, 568.0]])
 # 2:     +-- UINavigationTransitionView(#b09a310, [[0.0, 0.0], [320.0, 568.0]])
 # 3:     |   `-- UIViewControllerWrapperView(#b09c210, [[0.0, 64.0], [320.0, 504.0]])
 # 4:     |       `-- UIView(#b09ba20, [[0.0, 0.0], [320.0, 504.0]])
 # 5:     |           +-- UIButton(#b2398e0, [[11.0, 30.0], [289.0, 68.0]])
 # 6:     |           |   +-- UIImageView(#b09e3a0, [[0.0, 0.0], [289.0, 68.0]])
 # 7:     |           |   `-- UIButtonLabel(#b23b810, [[289.0, 34.0], [294.0, 0.0]], text: "Button")
 # 8:     |           +-- UIButton(#b23c630, [[11.0, 135.0], [289.0, 68.0]])
 # 9:     |           |   +-- UIImageView(#b09dfc0, [[0.0, 0.0], [289.0, 68.0]])
 #10:     |           |   `-- UIButtonLabel(#b23d470, [[289.0, 34.0], [294.0, 0.0]], text: "Button")
 #11:     |           `-- UIButton(#b23e0d0, [[11.0, 247.0], [289.0, 68.0]])
 #12:     |               +-- UIImageView(#b09ced0, [[0.0, 0.0], [289.0, 68.0]])
 #13:     |               `-- UIButtonLabel(#b09b740, [[289.0, 34.0], [294.0, 0.0]], text: "Button")
 #14:     `-- UINavigationBar(#b236520, [[0.0, 20.0], [320.0, 44.0]])
 #15:         +-- _UINavigationBarBackground(#b2377f0, [[0.0, 0.0], [320.0, 44.0]])
 #16:         |   `-- UIImageView(#b237e00, [[0.0, 44.0], [320.0, 3.0]])
 #17:         `-- UINavigationItemView(#b236940, [[59.0, 9.0], [202.0, 27.0]])
end