class NewsViewController < Nitron::TableViewController
  collection { News.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      News.refresh {
        view.pullToRefreshView.stopAnimating
      }
    })
    view.pullToRefreshView.setTitle('下拉刷新', forState:SVPullToRefreshStateStopped)
    view.pullToRefreshView.setTitle('放手刷新', forState:SVPullToRefreshStateTriggered)

    unless News.first
      puts 'No news data, pull to refresh...'
      view.triggerPullToRefresh
    end
  end

  def tableView(tableView, willDisplayCell:cell, forRowAtIndexPath:indexPath)
    model = tableView.dataSource.objectAtIndexPath(indexPath)
    logo_image = cell.viewWithTag(1)
    logo_image.setImageWithURL(model.logo, placeholderImage:App.delegate.placeholder_image)
  end
end