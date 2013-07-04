class CourseMapViewController < Nitron::ViewController
  def viewDidLoad
    super
    club = TiantaiClub.new
    region = MKCoordinateRegionMake(club.coordinate, MKCoordinateSpanMake(0.5, 0.5))
    mapView.setRegion(region)
    mapView.addAnnotation(club)
  end

private
  class TiantaiClub
    def title; '天泰温泉'; end
    def coordinate; CLLocationCoordinate2D.new(36.433333, 120.644732); end
  end
end