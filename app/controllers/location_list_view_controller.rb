class LocationListViewController < UITableViewController
  include Locateable

  CELL_ID = 'CellIdentifier'

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def viewWillAppear(animated)
    navigationItem.title = 'Locations'
    navigationItem.leftBarButtonItem = editButtonItem
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

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    location_view_controller = storyboard.instantiateViewControllerWithIdentifier('Detail')
    location_view_controller.location = LocationsStore.shared.locations[indexPath.row]
    navigationController.pushViewController(location_view_controller, animated: true)
  end

  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    location = LocationsStore.shared.locations[indexPath.row]
    LocationsStore.shared.remove_location(location)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
  end

  def prepareForSegue(segue, sender:id)
    # if ([[segue identifier] isEqualToString:@"showDetail"]) {
    #   NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    #   NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    #   [[segue destinationViewController] setDetailItem:object];
    # }
    if segue.identifier == 'showLocation'
      location = LocationsStore.shared.locations[tableView.indexPathForSelectedRow]
      segue.destinationViewController.location = location
    end
  end
end
