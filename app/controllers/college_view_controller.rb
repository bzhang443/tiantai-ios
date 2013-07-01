class CollegeViewController < Nitron::ViewController
  def viewDidLoad
    super
    tableView.dataSource = dataSource

    tableView.addPullToRefreshWithActionHandler(lambda {
      College.refresh
      tableView.pullToRefreshView.stopAnimating
    })

    unless College.first
      puts 'No college data, pull to refresh...'
      tableView.triggerPullToRefresh
    end
  end

  def controllerDidChangeContent(controller)
    tableView.reloadData()
  end

  def dataSource
    @_dataSource ||= begin
      CoreDataSource.alloc.initWithRequest(College.all, owner:self)
    end
  end

  def prepareForSegue(segue, sender:sender)
    model = nil

    if tableView.indexPathForSelectedRow
      model = dataSource.objectAtIndexPath(tableView.indexPathForSelectedRow)
    end

    if model
      controller = segue.destinationViewController
      controller.model = model
    end
  end

protected
  class CoreDataSource
    def initWithRequest(request, owner:owner)
      if init
        context = App.delegate.managedObjectContext

        @controller = NSFetchedResultsController.alloc.initWithFetchRequest(request,
                                                                            managedObjectContext:context,
                                                                            sectionNameKeyPath:nil,
                                                                            cacheName:nil)
        @controller.delegate = owner

        errorPtr = Pointer.new(:object)
        unless @controller.performFetch(errorPtr)
          raise "Error fetching data"
        end
      end

      self
    end

    def objectAtIndexPath(indexPath)
      @controller.objectAtIndexPath(indexPath)
    end

    def tableView(tview, cellForRowAtIndexPath:indexPath)
      cell = tview.dequeueReusableCellWithIdentifier('CollegeCell')
      model = objectAtIndexPath(indexPath)
      Nitron::UI::DataBinder.shared.bind(model, cell)
      cell
    end

    def tableView(tview, numberOfRowsInSection:section)
      @controller.sections[section].numberOfObjects
    end

  end  # end of CoreDataSource

end