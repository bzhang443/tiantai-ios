class HomeViewController < UIViewController

  HALF_PI = 1.57079632679489661923132169163975144

  def viewDidLoad
    super
    Profile.device_signup

    menu_y = self.view.bounds.size.height - 210
    @menu = QuadCurveMenu.alloc.initWithFrame([[160,menu_y],[210,210]], withArray:['1', '2', '3'])
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
    case item.dataObject
      when '1'  #setting
        self.performSegueWithIdentifier('ShowSetting', sender: self)
      when '2'
        self.performSegueWithIdentifier('ShowBooking', sender: self)
      when '3'
        self.performSegueWithIdentifier('ShowNews', sender: self)
      else
        puts "What for #{item.dataObject}?"
    end
  end

end