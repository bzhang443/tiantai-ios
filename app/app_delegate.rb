include SugarCube::Adjust

class AppDelegate
  include NetworkHelper

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @application = application

    show_flash

    @window.makeKeyAndVisible

    true
  end

  def show_flash
    @application.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationNone)

    @image_view = UIImageView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @image_view.animationImages = ['kaiji-2.jpg'.uiimage, 'kaiji-3.jpg'.uiimage, 'kaiji-1.jpg'.uiimage]
    @image_view.animationDuration = 16.0
    @image_view.animationRepeatCount = 100
    @image_view.startAnimating

    @tap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'handleTapGesture:')
    @window.addGestureRecognizer(@tap)
    @window.addSubview @image_view
    @window.bringSubviewToFront(@image_view)
  end

  def dismiss_flash
    return unless @image_view
    @image_view.removeFromSuperview
    @image_view = nil
    @window.removeGestureRecognizer(@tap)

    @application.setStatusBarHidden(false, withAnimation:UIStatusBarAnimationNone)
    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.rootViewController.wantsFullScreenLayout = true
  end

  def handleTapGesture(sender)
    dismiss_flash
  end

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

  def get_image(url, &block)
    manager = SDWebImageManager.sharedManager
    manager.downloadWithURL(url.nsurl, options:0, progress:nil,
          completed:lambda {|image, error, type, finished| block.call(image)}
    )
  end
end