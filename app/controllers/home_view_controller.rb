class HomeViewController < UIViewController

  HALF_PI = 1.57079632679489661923132169163975144

  def viewDidLoad
    self.navigationController.navigationBar.setBackgroundImage('top.png'.uiimage, forBarMetrics:UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setBackButtonBackgroundImage('navi_back.png'.uiimage, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setTitle('返回')
    menu_y = self.view.bounds.size.height - 230
    @menu = QuadCurveMenu.alloc.initWithFrame([[150,menu_y],[210,210]], withArray:['1', '2', '3'])
    dir = QuadCurveRadialDirector.alloc.initWithMenuWholeAngle(HALF_PI, andInitialRotation:-1*HALF_PI)
    dir.endRadius = 100
    @menu.setMenuDirector(dir)
    main_menu = QuadCurveDefaultMenuItemFactory.alloc.initWithImage('menu'.uiimage, highlightImage:nil)
    @menu.setMainMenuItemFactory(main_menu)
    @menu.setMenuItemFactory(self)
    self.view.addSubview @menu
    @menu.delegate = self
  end

  IMGS = {'1'=>'menu-setting', '2'=>'menu-book', '3'=>'menu-event'}
  def createMenuItemWithDataObject(data)
    img = IMGS[data].uiimage
    item = QuadCurveMenuItem.alloc.initWithImage(img, highlightedImage:nil)
    item.dataObject = data
    item
  end

  def quadCurveMenu(menu, didTapMenuItem: item)
    puts "MenuItem tapped: #{item.dataObject}"
    case item.dataObject
      when '1'  #setting
        self.performSegueWithIdentifier('ShowProfile', sender: self)
      else
        puts 'not implemented yet'
    end
  end

end