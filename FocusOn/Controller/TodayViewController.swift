//
//  TodayViewController.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
  
  @IBOutlet weak var todoTableView: UITableView!
  
  @IBOutlet weak var addGoalButton: UIButton!
  
  @IBOutlet weak var addTaskButton: UIButton!
  
  @IBOutlet weak var goalInput: UITextField!
  
  @IBOutlet weak var goalAccomplishedButton: UIButton!
  
  
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBAction func addGoalTapped(_ sender: UIButton) {
  }
  
  @IBAction func addTaskTapped(_ sender: UIButton) {
  }
  
  @IBAction func goalAccomplishedTapped(_ sender: UIButton) {
  }
  
}
