class FeedbackViewController <  Nitron::ViewController
  on :submit do
    puts 'submited'
    UIAlertView.alert "感谢您的反馈" { self.navigationController.popViewControllerAnimated(false) }
  end
end