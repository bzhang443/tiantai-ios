class FacilityViewController < Nitron::TableViewController
  collection { Facility.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      Facility.refresh
      view.pullToRefreshView.stopAnimating
    })
  end

end