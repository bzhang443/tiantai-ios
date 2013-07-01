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
    App.open_url 'telprompt://053286579888'
  end

end