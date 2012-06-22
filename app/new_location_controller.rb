class NewLocationController < UIViewController
  CANCEL_BUTTON_TAG = 100
  SAVE_BUTTON_TAG = 101

  attr_accessor :lat, :lng, :map

  def viewDidLoad
    # navigationItem.currentLeftView.
    #   addTarget(self, action: 'cancel_button_pressed:',
    #             forControlEvents: UIControlEventTouchUpInside)

    # if button = view.viewWithTag(CANCEL_BUTTON_TAG)
    #   button.addTarget(self, action: 'cancel_button_pressed:',
    #                    forControlEvents: UIControlEventTouchUpInside)
    # end
  end

  def viewWillAppear(animated)
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(UIBarButtonSystemItemSave,
                                  target:self,
                                  action:'addLocation')
    navigationItem.rightBarButtonItem.enabled = false

    @location_manager ||= CLLocationManager.alloc.init.tap do |lm|
      lm.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
      lm.startUpdatingLocation
      lm.delegate = self
    end

    @location_manager.location.coordinate.tap do |coordinate|
      lat.text = '%0.3f' % coordinate.latitude
      lng.text = '%0.3f' % coordinate.longitude
    end
  end

  def addLocation
    LocationsStore.shared.add_location do |location|
      coordinate = @location_manager.location.coordinate
      location.creation_date = NSDate.date
      location.latitude = coordinate.latitude
      location.longitude = coordinate.longitude
    end
    # view.reloadData
    # view.dismissModalViewController(animated: true)
    performSegueWithIdentifier('locationCreated', sender: self)
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    navigationItem.rightBarButtonItem.enabled = true
  end

  def locationManager(manager, didFailWithError:error)
    navigationItem.rightBarButtonItem.enabled = false
  end

  private

  # TODO Add this method to UIViewController or a descendent
  # def find_subview_with_tag(tag)
  #   view.subviews.detect { |v| v.tag == tag } or view
  # end
end
