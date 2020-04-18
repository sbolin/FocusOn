//
//  TodayTaskCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/17/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class TodayTaskCell: UITableViewCell {
  
  @IBOutlet weak var todayTaskCountLabel: UIImageView!
  @IBOutlet weak var todayTaskCheckMarkButton: UIButton!
  @IBOutlet weak var todayTaskTextField: UITextField!
  
  
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
