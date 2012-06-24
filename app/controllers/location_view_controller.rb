class LocationViewController < UITableViewController
  include Locateable

  attr_reader :location

  CELLS = [
    :nameCell, :latCell, :lngCell, :mapCell
  ]

  attr_accessor *CELLS

  def location=(new_location)
    @location = new_location
  end

  def viewWillAppear(animated)
    add_right_navigation_button

    blank_all_details

    with_current_location do |coordinate|
      set_detail_label(latCell, '%0.3f' % coordinate.latitude)
      set_detail_label(lngCell, '%0.3f' % coordinate.longitude)
    end
  end

  def viewDidLoad
    configure_view
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    enable_right_navigation_button
    configure_view
  end

  def locationManager(manager, didFailWithError:error)
    disable_right_navigation_button
  end

  private

  def configure_view
    if location
      set_detail_label(nameCell, 'Not Implemented')
      set_detail_label(latCell, '%0.3f' % location.latitude)
      set_detail_label(lngCell, '%0.3f' % location.longitude)

      # lat.text = '%0.3f' % location.latitude
      # lng.text = '%0.3f' % location.longitude

      # center_map
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

  def add_right_navigation_button
    return if location
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.
      initWithBarButtonSystemItem(UIBarButtonSystemItemSave,
                                  target:self,
                                  action:'addLocation')
    navigationItem.rightBarButtonItem.enabled = false
  end

  def enable_right_navigation_button
    return if location
    navigationItem.rightBarButtonItem.enabled = true
  end

  def disable_right_navigation_button
    return if location
    navigationItem.rightBarButtonItem.enabled = false
  end

  def blank_all_details
    CELLS.each { |cell| set_detail_label(send(cell), '') }
  end

  def set_detail_label(cell, text)
    if detail_label = cell.detailTextLabel
      detail_label.text = text
    end
  end

  # def center_map
  #   map.setRegion(map.regionThatFits(map_region), animated: false)
  # end

  # def map_region
  #   MKCoordinateRegionMakeWithDistance(location.core_location.coordinate,
  #                                      200, 200)
  # end
end
