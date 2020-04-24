//
//  TodayTaskCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

protocol NewTodayTaskCellDelegate {
  func newTaskCellText(_ cell: TodayTaskCell, newTaskCreated taskText: String)
  func newTaskCellCompletion(_ cell: TodayTaskCell, completionChanged completion: Bool)
}

class TodayTaskCell: UITableViewCell, UITextFieldDelegate {
  
  //MARK: - Properties
  var delegate: NewTodayTaskCellDelegate?
  
  // MARK: - IBOutlets
  @IBOutlet weak var todayTaskTextField: UITextField!
  @IBOutlet weak var todayTaskCountLabel: UIImageView!
  @IBOutlet weak var todayTaskCheckMarkButton: UIButton!
  
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    todayTaskTextField.delegate = self
  }
  
  //TODO: - override func prepareForReuse() { }
  
  // MARK: - Helper functions
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    processInput()
    return true
  }
  
  func fetchInput() -> String? {
    if let textCapture = todayTaskTextField.text?.trimmingCharacters(in: .whitespaces) {
      return textCapture.count > 0 ? textCapture : nil
    }
    return nil
  }
  
  func processInput() {
    if let textCapture = fetchInput() {
      delegate?.newTaskCellText(self, newTaskCreated: textCapture)
    }
    todayTaskTextField.text = ""
    todayTaskTextField.resignFirstResponder()
  }
  
  func markCompleted(_ completed: Bool) {
      todayTaskCheckMarkButton.isSelected = completed
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
  }
  
  // MARK: - IBActions
  @IBAction func inputTextChanged(_ sender: Any) {
    
  }
  
  
  @IBAction func checkmarkTapped(_ sender: UIButton) {
    markCompleted(!todayTaskCheckMarkButton.isSelected)
    delegate?.newTaskCellCompletion(self, completionChanged: todayTaskCheckMarkButton.isSelected)
  }
}
