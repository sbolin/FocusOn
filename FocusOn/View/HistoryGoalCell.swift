//
//  HistoryGoalCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class HistoryGoalCell: UITableViewCell {
  
  //MARK: - IBOutlets
  @IBOutlet weak var historyGoalCheckMarkButton: UIButton!
  @IBOutlet weak var historyGoalTextField: UITextField!
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCheckmark()
  }
  
  //MARK: - Helper Functions
  func configureCheckmark() {
    historyGoalCheckMarkButton.setImage(nil, for: .normal)
    historyGoalCheckMarkButton.setImage(UIImage.init(named: "LargeCheckMark"), for: .selected)
  }
  
  func markCompleted(_ completed: Bool) {
    historyGoalCheckMarkButton.isSelected = completed
  }
  
  func setHistoryGoalText(_ textLabel: String) {
    historyGoalTextField.text = textLabel
  }
}
