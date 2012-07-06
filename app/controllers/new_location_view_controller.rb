class NewLocationViewController < UIViewController
  include Locateable

  attr_accessor :lat, :lng
  attr_reader :coordinate

  def viewDidLoad
    view.delegate = self
  end

  def viewWillAppear(animated)
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(UIBarButtonSystemItemSave,
                                  target:self,
                                  action:'addLocation')
    navigationItem.rightBarButtonItem.enabled = false

    lat.text = ''
    lng.text = ''

    cache_location

    with_current_location do |coordinate|
      lat.text = '%0.3f' % coordinate.latitude
      lng.text = '%0.3f' % coordinate.longitude
    end
  end

  def addLocation
    LocationsStore.shared.add_location do |location|
      location.creation_date = NSDate.date

      location.latitude = coordinate.latitude
      location.longitude = coordinate.longitude
    end

    performSegueWithIdentifier('locationCreated', sender: self)
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    navigationItem.rightBarButtonItem.enabled = true
    self.current_location = newLocation
  end

  def locationManager(manager, didFailWithError:error)
    navigationItem.rightBarButtonItem.enabled = false
  end

  def prepareForSegue(segue, sender:id)
    if segue.identifier == 'showMap'
      segue.destinationViewController.lat = location
    end
  end

  def current_location=(new_location)

  end

  private

  def cache_location
    location = location_manager.location
    if location && coordinate = location.coordinate
      self.coordinate = coordinate
    end
  end
end
