class NewLocationViewController < UIViewController
  include Locateable

  attr_accessor :lat, :lng, :map

  def viewWillAppear(animated)
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(UIBarButtonSystemItemSave,
                                  target:self,
                                  action:'addLocation')
    navigationItem.rightBarButtonItem.enabled = false

    lat.text = ''
    lng.text = ''

    with_current_location do |coordinate|
      lat.text = '%0.3f' % coordinate.latitude
      lng.text = '%0.3f' % coordinate.longitude
    end
  end

  def addLocation
    LocationsStore.shared.add_location do |location|
      location.creation_date = NSDate.date

      with_current_location do |coordinate|
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
      end
    end

    performSegueWithIdentifier('locationCreated', sender: self)
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    navigationItem.rightBarButtonItem.enabled = true
  end

  def locationManager(manager, didFailWithError:error)
    navigationItem.rightBarButtonItem.enabled = false
  end
end
