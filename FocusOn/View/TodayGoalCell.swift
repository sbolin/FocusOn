//
//  TodayGoalCell.swift
//  FocusOn
//
//  Created by Scott Bolin on 4/18/20.
//  Copyright © 2020 Scott Bolin. All rights reserved.
//

import UIKit

class TodayGoalCell: UITableViewCell {

  @IBOutlet weak var todoGoalTextField: UITextField!
  @IBOutlet weak var todayGoalCheckMarkButton: UIButton!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
