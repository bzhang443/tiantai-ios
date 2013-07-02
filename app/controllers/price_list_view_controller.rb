class PriceListViewController <  Nitron::ViewController
  def viewDidLoad
    super

    scroller.addPullToRefreshWithActionHandler(lambda {
      Price.refresh { self.model = Price.new }
      scroller.pullToRefreshView.stopAnimating
    })

    if Price.first
      self.model = Price.new
    else
      puts 'No price data, pull to refresh...'
      scroller.triggerPullToRefresh
    end
  end

  on :callButton do
    if App.shared.canOpenURL('tel://'.nsurl)
      App.open_url 'telprompt://053286579888'
    else
      App.alert '您的设备不支持电话呼叫'
    end

  end

end