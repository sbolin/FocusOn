//
//  TodayGoalCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

protocol NewTodayGoalCellDelegate {
  func newGoalCell(_ cell: TodayGoalCell, newGoalCreated goalText: String)
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
    todayGoalTextField.delegate = self
  }
  
  //MARK: - Helper functions
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
      delegate?.newGoalCell(self, newGoalCreated: textCapture)
    }
    todayGoalTextField.text = ""
    todayGoalTextField.resignFirstResponder()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
  }
  
  // MARK: - IBActions
  @IBAction func inputTextChanged(_ sender: Any) {
    
  }
}
