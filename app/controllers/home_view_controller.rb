class HomeViewController < UIViewController

  HALF_PI = 1.57079632679489661923132169163975144

  def viewDidLoad
    self.navigationController.navigationBar.setBackgroundImage('top.png'.uiimage, forBarMetrics:UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setBackButtonBackgroundImage('navi_back.png'.uiimage, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    #UIBarButtonItem.appearance.setTitle('返回')

    @menu = QuadCurveMenu.alloc.initWithFrame([[100,260],[210,210]], withArray:['1', '2', '3'])
    dir = QuadCurveRadialDirector.alloc.initWithMenuWholeAngle(HALF_PI, andInitialRotation:-1*HALF_PI)
    dir.endRadius = 100
    @menu.setMenuDirector(dir)
    main_menu = QuadCurveDefaultMenuItemFactory.alloc
      .initWithImage('bg-addbutton.png'.uiimage, highlightImage:'bg-addbutton-highlighted.png'.uiimage)
    @menu.setMainMenuItemFactory(main_menu)
    menu_item = QuadCurveDefaultMenuItemFactory.alloc
      .initWithImage("bg-menuitem.png".uiimage,  highlightImage:"bg-menuitem-highlighted.png".uiimage)
    @menu.setMenuItemFactory(menu_item)
    self.view.addSubview @menu
    @menu.delegate = self
  end

  def quadCurveMenu(menu, didTapMenuItem: item)
    puts "MenuItem tapped: #{item.dataObject}"
  end

end