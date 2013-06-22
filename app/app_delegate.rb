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
  end

  def network_reachable?
    @hostReachable.isReachable
  end

end