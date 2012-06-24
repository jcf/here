class DetailViewController < UIViewController
  attr_reader :location

  attr_accessor :lat, :lng, :map

  def location=(new_location)
    @location = new_location
  end

  def viewDidLoad
    configure_view
  end

  private

  def configure_view
    if location
      lat.text = '%0.3f' % location.latitude
      lng.text = '%0.3f' % location.longitude

      center_map
    end
  end

  def center_map
    map.setRegion(map.regionThatFits(map_region), animated: false)
  end

  def map_region
    MKCoordinateRegionMakeWithDistance(location.core_location.coordinate,
                                       200, 200)
  end
end
