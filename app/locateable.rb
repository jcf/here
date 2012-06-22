module Locateable
  private

  def location_manager
    @location_manager ||= CLLocationManager.alloc.init.tap do |lm|
      lm.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
      lm.startUpdatingLocation
      lm.delegate = self
    end
  end

  def with_current_location
    location = location_manager.location

    if location && coordinate = location.coordinate
      yield coordinate
    end
  end
end
