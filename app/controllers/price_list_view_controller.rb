class PriceListViewController <  Nitron::ViewController
  def viewDidLoad
    super

    scroller.addPullToRefreshWithActionHandler(lambda {
      Price.refresh { self.model = Price.new }
      scroller.pullToRefreshView.stopAnimating
    })

    self.model = Price.new if Price.first
    scroller.triggerPullToRefresh
  end

  on :callButton do
    if App.shared.canOpenURL('tel://'.nsurl)
      App.open_url 'telprompt://053286579888'
    else
      App.alert '您的设备不支持电话呼叫'
    end
  end

end