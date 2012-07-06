class MapViewController < UIViewController
  attr_accessor :map

  def viewWillAppear(animated)
    map.setRegion(map.regionThatFits(map_region), animated: true)
  end

  private

  def map_region
    MKCoordinateRegionMakeWithDistance(location.core_location.coordinate,
                                       200, 200)
  end
end
