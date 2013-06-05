class CollegeViewController < Nitron::TableViewController
  collection { College.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      College.refresh
      view.pullToRefreshView.stopAnimating
    })
  end

end