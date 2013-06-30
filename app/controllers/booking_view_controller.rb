class BookingViewController < Nitron::ViewController
  DATE_FORMAT = "%m-%d %H:%M"
  def viewDidLoad
    super
    @names = Price.valid_price_names
    form_reset
  end

  on :productButton do
    @product_picker = CEPopupPickerView.alloc.initWithValues(@names,
      callback: lambda {|index| productField.text =  @names[index] }
    )
    @product_picker.presentInView(self.view)
  end

  on :dateButton do
    datePanel.show
  end

  on :dateDismiss do
    datePanel.hide
  end

  on :dateUpdate do
    datePanel.hide
    dateField.text = datePicker.date.string_with_format(DATE_FORMAT)
  end

  on :reset do
    form_reset
  end

  on :submit do
    data = {
        :price_id => Price.to_id(productField.text),
        :name     => nameField.text,
        :date     => dateField.text,
        :mobile   => mobileField.text,
        :friends  => friendsField.text,
        :memo     => memoField.text
    }
    if data[:name].blank? || data[:mobile].blank?
      App.alert '姓名和联系电话必须填'
    else
      Booking.add(data) do
        UIAlertView.alert '您的订场已经提交' { self.navigationController.popViewControllerAnimated(false) }
      end
    end
  end

private
  def form_reset
    profile = Profile.load
    dateField.text    = NSDate.new.string_with_format(DATE_FORMAT)
    productField.text = @names[0]
    nameField.text    = profile.name
    friendsField.text = "0"
    mobileField.text  = profile.mobile
    memoField.text    = ""
  end
end