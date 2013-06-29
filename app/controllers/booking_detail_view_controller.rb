class BookingDetailViewController < Nitron::ViewController

  on :delete do
    UIAlertView.alert('确认删除当前订场记录？', buttons: ['取消','确认'], message: '删除不可恢复') do |button|
      if button == '确认'
        Booking.delete(self.model.order_id) do
          self.navigationController.popViewControllerAnimated(false)
        end
      end
    end
  end

end