class NewsViewController < Nitron::TableViewController
  collection { News.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      News.refresh
      view.pullToRefreshView.stopAnimating
    })
  end

end