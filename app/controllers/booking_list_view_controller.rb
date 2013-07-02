class BookingListViewController < Nitron::TableViewController
  collection { Booking.all }

  def viewDidLoad
    super

    class << view.dataSource
      def tableView(tableView, titleForHeaderInSection:section)
        '　时间 　　　　名称　　　  状态'
      end
    end

    view.addPullToRefreshWithActionHandler(lambda {
      Booking.refresh
      view.pullToRefreshView.stopAnimating
    })

    view.triggerPullToRefresh
  end

end