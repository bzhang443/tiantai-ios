describe News do
  # refer to http://fearoffish.com/stubbing-rubymotion-http/
  extend WebStub::SpecHelpers

  before do
    disable_network_access!
  end

  describe "#refresh" do
    before do
      @successful_news_response = '{"status": 0, "list": [{"title": "baidu", "link": "http://baidu.com"},{"title": "google", "link": "http://google.com"}]}'
    end

    it "should got 2 news" do
      stub_request(:get, "http://125.208.5.139:3000/api/news_list").to_return(body: @successful_news_response, content_type: 'application/json')

      News.refresh

      wait_max 10.0 do
        @news_list = News.all
        @news_list.count.should == 2
      end
    end
  end

end