class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # nav = UINavigationController.alloc.initWithRootViewController(LocationsController.alloc.init)
    # nav.wantsFullScreenLayout = true
    # nav.toolbarHidden = true

    # @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # @window.rootViewController = nav
    # @window.makeKeyAndVisible

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    storyboard = UIStoryboard.storyboardWithName('Here_iPhone', bundle: nil)
    rootViewController = storyboard.
      instantiateViewControllerWithIdentifier('Navigation')
    @window.rootViewController = rootViewController
    @window.rootViewController.wantsFullScreenLayout = false
    @window.makeKeyAndVisible

    true
  end
end
