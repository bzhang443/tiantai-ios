class BookingListViewController < Nitron::TableViewController
  collection { Booking.all }

  def viewDidLoad
    super

    class << view.dataSource
      def tableView(tableView, titleForHeaderInSection:section)
        if Booking.first
          '　时间 　　　　名称　　　  状态'
        else
          '  还没有订场记录'
        end
      end
    end

    view.addPullToRefreshWithActionHandler(lambda {
      Booking.refresh
      view.pullToRefreshView.stopAnimating
    })

    view.triggerPullToRefresh
  end

end