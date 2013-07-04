class FacilityViewController < Nitron::TableViewController
  collection { Facility.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      Facility.refresh {
        view.pullToRefreshView.stopAnimating
      }
    })

    unless Facility.first
      puts 'No facility data, pull to refresh...'
      view.triggerPullToRefresh
    end
  end

  def tableView(tableView, willDisplayCell:cell, forRowAtIndexPath:indexPath)
    model = tableView.dataSource.objectAtIndexPath(indexPath)
    logo_image = cell.viewWithTag(1)
    logo_image.setImageWithURL(model.logo, placeholderImage:App.delegate.placeholder_image)
  end
  
end