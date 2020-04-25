//
//  HistoryTaskCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class HistoryTaskCell: UITableViewCell {
  
  //MARK: - IBOutlets
  @IBOutlet weak var historyTaskCheckMarkButton: UIButton!
  @IBOutlet weak var historyTaskTextField: UITextField!
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCheckmark()
  }
  
  //MARK: - Helper Functions
  func configureCheckmark() {
    historyTaskCheckMarkButton.setImage(nil, for: .normal)
    historyTaskCheckMarkButton.setImage(UIImage.init(named: "SmallCheckMark"), for: .selected)
  }
  
  func markCompleted(_ completed: Bool) {
    historyTaskCheckMarkButton.isSelected = completed
  }
  
  func setHistoryTaskText(_ textLabel: String) {
    historyTaskTextField.text = textLabel
  }
}
