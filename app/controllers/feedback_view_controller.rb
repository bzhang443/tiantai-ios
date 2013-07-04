class FeedbackViewController <  Nitron::ViewController
  on :submit do
    UIAlertView.alert "感谢您的反馈" { self.navigationController.pop }
  end
end