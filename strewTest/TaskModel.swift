//
//  TaskModel.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//
import RealmSwift

// Task model
class Task: Object {
    dynamic var name = ""
    dynamic var priority = 0 // 1=Very Low / 2=Low / 3=Medium / 4=High / 5=Very High
    dynamic var created_at = Date()
    dynamic var completed = false
    dynamic var completed_at = Date()
    dynamic var id = 0
}

class TaskList: Object {
    var list = List<Task>()
}
