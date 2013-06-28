class FacilityViewController < Nitron::TableViewController
  collection { Facility.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      Facility.refresh
      view.pullToRefreshView.stopAnimating
    })

    unless Facility.first
      puts 'No facility data, pull to refresh...'
      view.triggerPullToRefresh
    end
  end

end