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
public var realm = try! Realm() // Create realm pointing to default file
