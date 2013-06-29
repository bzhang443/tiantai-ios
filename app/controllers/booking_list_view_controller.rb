class BookingListViewController < Nitron::TableViewController
  collection { Booking.all }

  def viewDidLoad
    super

    view.addPullToRefreshWithActionHandler(lambda {
      Booking.refresh
      view.pullToRefreshView.stopAnimating
    })

    #unless Booking.first
    #  puts 'No college data, pull to refresh...'
    #  view.triggerPullToRefresh
    #end
  end


end