//
//  TodayViewController.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit
import CoreData

class TodayViewController: UIViewController {
  
  //MARK: - Properties
  fileprivate let goalCell = "TodayGoalCell"
  fileprivate let todoCell = "TodayTaskCell"
  
  //MARK: CoreDataStack
  lazy var coreDataStack = CoreDataStack(modelName: "FocusOn")
  lazy var fetchedResultsController: NSFetchedResultsController<Goal> = {
    let fetchRequest: NSFetchRequest<Goal> = Goal.createFetchRequest()
    
    let dateSort = NSSortDescriptor(key: #keyPath(Goal.dateCreated), ascending: false)
    
    fetchRequest.sortDescriptors = [dateSort]
    
    //sectionNameKeyPath: last dateCreated for Today, all for History
    
    
    let fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: coreDataStack.managedContext,
      sectionNameKeyPath: #keyPath(Goal.dateCreated),
      cacheName: "focusOnCache")
    
    fetchedResultsController.delegate = self
    
    return fetchedResultsController
  }()
  var goals: [Goal] = []
  
  // MARK: DiffableData setup
  var dataSource: UITableViewDiffableDataSource<Int, Goal>?
  var diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Goal>()
  
  // MARK: - IBOutlets
  @IBOutlet weak var todayTableView: UITableView!
  @IBOutlet weak var addGoalButton: UIButton!
  @IBOutlet weak var addTaskButton: UIButton!
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = setupDataSource()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  // MARK: - Navigation
  
}
//MARK: - IBActions
extension TodayViewController {
  @IBAction func addGoalTapped(_ sender: UIButton) {
  }
  
  @IBAction func addTaskTapped(_ sender: UIButton) {
  }
}

// MARK: - UITableViewDiffableDataSource
extension TodayViewController {
  
  func setupDataSource() -> UITableViewDiffableDataSource<Int, Goal> {
    return UITableViewDiffableDataSource(tableView: todayTableView) { (tableView, indexPath, goal) -> UITableViewCell? in
      var cellID = ""
      let section = indexPath.section
      
      if section == 0 {
        cellID = self.goalCell
      } else if section == 1 {
        cellID = self.todoCell
      }
      let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
      self.configure(cell: cell, for: indexPath)
      return cell
    }
  }
  
  func configure(cell: UITableViewCell, for indexPath: IndexPath) {
    let section = indexPath.section
    if section == 0 {
      guard let cell = cell as? TodayGoalCell else { return }
      let fetchedGoal = fetchedResultsController.object(at: indexPath)
      cell.todayGoalTextField.text = fetchedGoal.goal
      cell.todayGoalCheckMarkButton.isSelected = false
    } else if section == 1 {
      guard let cell = cell as? TodayTaskCell else { return }
      let fetchedToDo = fetchedResultsController.object(at: indexPath)
      cell.todayTaskTextField.text = fetchedToDo.latestToDo?.todo
      //Entity object.relationship name.relationship Entity attribute
      
      cell.todayTaskCheckMarkButton.isSelected = false
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      //TODO: Get number of rows based on datasource
      return 3
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    if section == 0 {
      return "Goal for the day to Focus On"
    } else if section == 1 {
      //TODO: Get count of tasks
      // TodDo.todo.count
      return "3 Tasks to achieve your goal"
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 24
    } else if section == 1 {
      return 20
    }
    return 0
  }
}


// MARK: - UITableViewDelegate Methods
extension TodayViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = indexPath.section
    //TODO: Edit Tableview cell upon selection
    
  }
  
  //  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  //    let titleLabel = UILabel()
  //    titleLabel.font.withSize(10)
  //    titleLabel.backgroundColor = .lightGray
  //
  //    if section == 0 {
  //      titleLabel.text = "Goal for the day to Focus On"
  //    } else if section == 1 {
  //      titleLabel.text = "3 Tasks to achieve your goal"
  //    }
  //
  //    return titleLabel
  //  }
}

// MARK: - NSFetchedResultsControllerDelegate
extension TodayViewController: NSFetchedResultsControllerDelegate {
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    
    var diff = NSDiffableDataSourceSnapshot<Int, Goal>()
    snapshot.sectionIdentifiers.forEach { section in
      
      diff.appendSections([section as! Int])
      
      let items = snapshot.itemIdentifiersInSection(withIdentifier: section)
        .map { (objectId: Any) -> Goal in
          let oid = objectId as! NSManagedObjectID
          return controller
            .managedObjectContext
            .object(with: oid) as! Goal
      }
      
      diff.appendItems(items, toSection: section as? Int)
    }
    
    dataSource?.apply(diff)
  }
}

// MARK: - NewTodayGoalCellDelegate: newGoalCreated Method
extension TodayViewController: NewTodayGoalCellDelegate {
  func newGoalCellText(_ cell: TodayGoalCell, newGoalCreated goalText: String) {
    // create new goal
    let goal = Goal(context: self.coreDataStack.managedContext)
    goal.goal = goalText
    goal.dateCreated = Date()
    goal.completedGoal = false
    self.coreDataStack.saveContext()

  }
  
  
}

// MARK: - NewTodayTaskCellDelegate: newTaskCreated, completionChanged Methods
extension TodayViewController: NewTodayTaskCellDelegate {
  func newTaskCellText(_ cell: TodayTaskCell, newTaskCreated taskText: String) {
    // create new task
    let todo = ToDo(context: self.coreDataStack.managedContext)
    todo.todo = taskText
    todo.dateCreated = Date()
    todo.completedTodo = false
    self.coreDataStack.saveContext()
  }
  
  func newTaskCellCompletion(_ cell: TodayTaskCell, completionChanged completion: Bool) {
    // identify the indexPath for the cell
    if let indexPath = todayTableView.indexPath(for: cell) {
      // fetch the datasource for the indexPath
      let todo = fetchedResultsController.object(at: indexPath)
      // update the completion handler
      todo.completedGoal = completion
      
      //TODO: update data model
    }
  }
}

