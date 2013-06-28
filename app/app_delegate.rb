include SugarCube::Adjust

class AppDelegate
  include NetworkHelper

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
    #UIBarButtonItem.appearance.setTintColor UIColor.darkGrayColor
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

end