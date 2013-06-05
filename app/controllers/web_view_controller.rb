class WebViewController < UIViewController
  attr_accessor :model

  def viewDidLoad
    self.title = self.model.title
    request = NSURLRequest.requestWithURL(NSURL.alloc.initWithString(self.model.link))
    self.view.loadRequest(request)
  end
end