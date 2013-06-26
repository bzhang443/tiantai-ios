include SugarCube::Adjust

class AppDelegate

  #def application(application, didFinishLaunchingWithOptions:launchOptions)
  #  application.setStatusBarStyle(UIStatusBarStyleBlackOpaque)
  #  @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  #  @window.rootViewController = FlashViewController.alloc.init
  #  application.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationFade)
  #  @window.rootViewController.wantsFullScreenLayout = true
  #  @window.makeKeyAndVisible
  #  true
  #end

  def initialize
    @internetReachable = Reachability.reachabilityForInternetConnection
    @internetReachable.startNotifier
    @hostReachable = Reachability.reachabilityWithHostname('www.baidu.com')
    @hostReachable.startNotifier

    UINavigationBar.appearance.setBackgroundImage('top'.uiimage, forBarMetrics: UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setBackButtonBackgroundImage('navi_back'.uiimage, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setTintColor UIColor.grayColor
    #title_text_attr = {
    #    'UITextAttributeTextColor'       => UIColor.greenColor,
    #    'UITextAttributeTextShadowColor' => UIColor.blackColor,
    #    'UITextAttributeTextShadowOffset'=> NSValue.valueWithUIOffset(UIOffsetMake(-1,0))
    #    }
    #UIBarButtonItem.appearance.setTitleTextAttributes(title_text_attr, forState: UIControlStateNormal)
  end

  def network_reachable?
    @hostReachable.isReachable
  end

  def api_for(service)
    "http://125.208.5.139:3000/api/#{service}"
  end

  def network_error_report
    App.alert "网络不好，请稍后再试"
  end

  def api_error_report
    App.alert "服务器故障，请稍后再试"
  end

end