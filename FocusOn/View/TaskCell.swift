//
//  TaskCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
  
  @IBOutlet weak var countLabel: UIImageView!
  @IBOutlet weak var checkMarkButton: UIButton!
  @IBOutlet weak var taskTextField: UITextField!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  @IBAction func checkmarkTapped(_ sender: UIButton) {
    
  }
}
