//
//  TaskCellModel.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    var task = Task()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bind(_ task: Task){
        self.task = task
        self.nameLabel.text = task.name
        
        switch task.priority{
        case 0:
            self.priorityLabel.text = "Low Priority"
            self.priorityLabel.textColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
            break
        case 1:
            self.priorityLabel.text = "Medium Priority"
            self.priorityLabel.textColor = UIColor(red: 255/255, green: 128/255, blue: 0, alpha: 1)
            break
        case 2:
            self.priorityLabel.text = "High Priority"
            self.priorityLabel.textColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
            break
        default:
            break
        }
    }
    
}
