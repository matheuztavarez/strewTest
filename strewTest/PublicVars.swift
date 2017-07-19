//
//  PublicVars.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
public let lightBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
// Realms are used to group data together
var realm = try! Realm() // Create realm pointing to default file

var taskList = [Results<Task>]()
var searchedTasks = [Results<Task>]()

func objectForIndexPath(indexPath: IndexPath) -> Task? {
    return taskList[indexPath.section][indexPath.row]
}

func presentYesNoAlert(title: String, message: String, view: UIViewController, yesHandler: ((UIAlertAction) -> Void)?, noHandler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: yesHandler)
    
    let noAction = UIAlertAction(title: "No", style: .cancel, handler: noHandler)
    
    alertController.addAction(yesAction)
    
    alertController.addAction(noAction)
    
    view.present(alertController, animated: true, completion: nil)
}
