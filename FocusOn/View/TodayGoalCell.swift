//
//  TodayGoalCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

protocol NewTodayGoalCellDelegate {
  func newGoalCellText(_ cell: TodayGoalCell, newGoalCreated goalText: String)
}

class TodayGoalCell: UITableViewCell, UITextFieldDelegate {
  
  // MARK: - Properties
  var delegate: NewTodayGoalCellDelegate?
  
  // MARK: - IBOutlets
  @IBOutlet weak var todayGoalTextField: UITextField!
  @IBOutlet weak var todayGoalCheckMarkButton: UIButton!
  
// MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCheckmark()
    todayGoalTextField.delegate = self
  }
  
  //TODO: - override func prepareForReuse() { }
  

  //MARK: - Helper functions
  func configureCheckmark() {
    todayGoalCheckMarkButton.setImage(nil, for: .normal)
    todayGoalCheckMarkButton.setImage(UIImage.init(named: "LargeCheckMark"), for: .selected)
  }
  
  func markCompleted(_ completed: Bool) {
    todayGoalCheckMarkButton.isSelected = completed
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    processInput()
    return true
  }
  
  func fetchInput() -> String? {
    if let textCapture = todayGoalTextField.text?.trimmingCharacters(in: .whitespaces) {
      return textCapture.count > 0 ? textCapture : nil
    }
    return nil
  }
  
  func processInput() {
    if let textCapture = fetchInput() {
      delegate?.newGoalCellText(self, newGoalCreated: textCapture)
    }
    todayGoalTextField.text = ""
    todayGoalTextField.resignFirstResponder()
  }
  
  // MARK: - IBActions
//  @IBAction func inputTextChanged(_ sender: Any) {
//    processInput()
//  }
}
