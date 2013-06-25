class NewsViewController < Nitron::TableViewController
  collection { News.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      News.refresh
      view.pullToRefreshView.stopAnimating
    })

    unless News.first
      puts 'No data, pull to refresh...'
      view.triggerPullToRefresh
    end
  end

end