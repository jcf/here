class MasterViewController < UITableViewController
  include Locateable

  CELL_ID = 'CellIdentifier'

  def viewDidLoad
    view.dataSource = view.delegate = self
    # @detailViewController = DetailViewController.alloc.init
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

  # - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  #
  # DetailViewController *dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:[NSBundle mainBundle]];
  # [self.navigationController pushViewController:dvController animated:YES];
  # [dvController release];
  # dvController = nil;
  # }
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # performSegueWithIdentifier('showLocation', sender: self)
    # navigationController.pushViewController(detailViewController, animated: true)
    # @detailViewController.location = LocationsStore.shared.locations[indexPath.row]

    detail_view_controller = storyboard.instantiateViewControllerWithIdentifier('Detail')
    detail_view_controller.location = LocationsStore.shared.locations[indexPath.row]
    navigationController.pushViewController(detail_view_controller, animated: true)
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
