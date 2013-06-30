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

  #SDWebImageManager *manager = [SDWebImageManager sharedManager];
  #[manager downloadWithURL:imageURL
  #                 options:0
  #                progress:nil
  #               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
  #                        {
  #                            if (image)
  #                            {
  #                                // do something with image
  #                            }
  #                        }
  # ];

  def get_image(url, &block)
    manager = SDWebImageManager.sharedManager
    manager.downloadWithURL(url.nsurl, options:0, progress:nil,
          completed:lambda {|image, error, type, finished| block.call(image)}
    )
  end
end