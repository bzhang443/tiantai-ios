class WebViewController < UIViewController
  attr_accessor :model

  def viewDidLoad
    self.title = self.model.title
    request = NSURLRequest.requestWithURL(self.model.link.nsurl)
    self.view.loadRequest(request)
  end
end