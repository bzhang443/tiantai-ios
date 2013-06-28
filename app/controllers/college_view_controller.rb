class CollegeViewController < Nitron::TableViewController
  collection { College.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      College.refresh
      view.pullToRefreshView.stopAnimating
    })

    unless College.first
      puts 'No college data, pull to refresh...'
      view.triggerPullToRefresh
    end
  end

end