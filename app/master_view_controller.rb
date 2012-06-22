class MasterViewController < UITableViewController
  include Locateable

  CELL_ID = 'CellIdentifier'

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def viewWillAppear(animated)
    navigationItem.title = 'Locations'
    navigationItem.leftBarButtonItem = editButtonItem

    location_manager # to request permission
  end

  def tableView(tableView, numberOfRowsInSection:section)
    LocationsStore.shared.locations.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CELL_ID)
    location = LocationsStore.shared.locations[indexPath.row]

    @date_formatter ||= NSDateFormatter.alloc.init.tap do |df|
      df.timeStyle = NSDateFormatterMediumStyle
      df.dateStyle = NSDateFormatterMediumStyle
    end

    cell.textLabel.text = @date_formatter.stringFromDate(location.creation_date)
    cell.detailTextLabel.text = "%0.3f, %0.3f" % [location.latitude, location.longitude]
    cell
  end

  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    location = LocationsStore.shared.locations[indexPath.row]
    LocationsStore.shared.remove_location(location)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
  end
end
