//
//  TodayViewController.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit
import CoreData


class TodayViewController: UIViewController, NSFetchedResultsControllerDelegate {
  
  @IBOutlet weak var todayTableView: UITableView!
  @IBOutlet weak var addGoalButton: UIButton!
  @IBOutlet weak var addTaskButton: UIButton!
  
  
  // CoreData Parameters
  var container = NSPersistentContainer(name: "FocusOn")
  var todoPredicate: NSPredicate?
  var todoFetchedResultsController: NSFetchedResultsController<ToDo>!
  var focusFetchedResultsController: NSFetchedResultsController<Focus>!
  
  var goals = [Focus]()
  
  // Diffable Data Parameters
//  var todoDiffableDataSource: UITableViewDiffableDataSource<Int, ToDo>?
//  var todoDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, ToDo>()
//
//  var focusDiffableDataSource: UITableViewDiffableDataSource<Int, Focus>?
//  var focusDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Focus>()
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    setupCoreData()
    setupFetchedResultsController()
 //   setupTableView()
    
//    performSelector(inBackground: #selector(fetchGoals), with: nil)
    loadSavedData()

    }
  
  //MARK: - Table View Setup Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return goals.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodayGoalCell", for: indexPath)
    
    let goal = goals[indexPath.row]
    cell.textLabel!.text = goal.goal
    
    return cell
  }
  
  
  
// diffable data source methods
//  private func setupTableView() {
//    focusDiffableDataSource = UITableViewDiffableDataSource<Int, Focus>(tableView: todayTableView, cellProvider: { (todayTableView, indexPath, focus) -> UITableViewCell? in
//
//      let cell = todayTableView.dequeueReusableCell(withIdentifier: "TodayGoalCell", for: indexPath)
//
//      cell.textLabel?.text = focus.goal
//      return cell
//    })
//
//    updateSnapshot()
//  }
  
//  private func updateSnapshot() {
//    focusDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Focus>()
//    focusDiffableDataSourceSnapshot.appendSections([0])
//    focusDiffableDataSourceSnapshot.appendItems(focusFetchedResultsController.fetchedObjects ?? [])
//    focusDiffableDataSource?.apply(self.focusDiffableDataSourceSnapshot)
//  }
  
  
  
  //MARK: - Core Data Methods
  
  // Setup the CoreData database
  private func setupCoreData() {
    container.loadPersistentStores { storeDescription, error in
      self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      if let error = error {
        print("Unable to load data \(error.localizedDescription)")
      }
    }
  }
  
  private func setupFetchedResultsController() {
    
  }
  
  // save CoreData to "disk"
  func saveContext() {
    if container.viewContext.hasChanges {
      do {
        try container.viewContext.save()
      } catch {
        print("An error occured while saving: \(error.localizedDescription)")
      }
    }
  }
  
//  @objc func fetchGoals() {
//
//    self.saveContext()
//    self.loadSavedData()
//  }
  
  func getNewestGoal() -> String {
         let formatter = ISO8601DateFormatter()
         
         let newest = Focus.createFetchRequest()
         let sort = NSSortDescriptor(key: "date", ascending: false)
         newest.sortDescriptors = [sort]
         newest.fetchLimit = 1
         
         if let goals = try? container.viewContext.fetch(newest) {
             if goals.count > 0 {
                 return formatter.string(from: goals[0].dateCreated.addingTimeInterval(1))
             }
         }
         return formatter.string(from: Date(timeIntervalSince1970: 0))
     }
  
  
  
  //MARK: - Helper Functions
  func loadSavedData() {
    if todoFetchedResultsController == nil {
      let request = Focus.createFetchRequest()
      let sort = NSSortDescriptor(key: "focus.dateCreated", ascending: true)
      request.sortDescriptors = [sort]
      focusFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: "focus.dateCreated", cacheName: nil)
      todoFetchedResultsController.delegate = self
    }
    todoFetchedResultsController.fetchRequest.predicate = todoPredicate
    
    do {
      try todoFetchedResultsController.performFetch()
      todayTableView.reloadData()
    } catch {
      print("Fetch failed")
    }
  }
  
    
  @IBAction func addGoalTapped(_ sender: UIButton) {
  }
  
  @IBAction func addTaskTapped(_ sender: UIButton) {
  }
  
}
