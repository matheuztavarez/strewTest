//
//  ViewController.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!

    var taskList = [Task]()
    var searchedTasks = [Task]()
    var selectedRow = 0
    var searchController: UISearchController!

    var notificationToken: NotificationToken?
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        self.hideKeyboardWhenTappedAround()
        
        realm = try! Realm()
        
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.tableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        getTasks()
        if(self.message != ""){
            showToast(self.message)
            self.message = ""
        }
    }

//    func backgroundAdd() {
//        // Import many items in a background thread
//        DispatchQueue.global().async {
//            // Get new realm and table since we are in a new thread
//            let realm = try! Realm()
//            realm.beginWrite()
//            for _ in 0..<5 {
//                // Add row via dictionary. Order is ignored.
//                realm.create(Task.self, value: ["title": randomTitle(), "date": NSDate(), "sectionTitle": randomSectionTitle()])
//            }
//            try! realm.commitWrite()
//        }
//    }
    
    func viewSetup() {

        searchController = UISearchController(searchResultsController: nil)

        self.definesPresentationContext = true

        searchController.searchResultsUpdater = self

        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.placeholder = "Search Task"
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["To Do", "Done", "All"]
        tableView.tableFooterView = UIView(frame: .zero)

        self.tableView.tableHeaderView = searchController.searchBar



        let footerView = UIView(frame: CGRect.zero)
        footerView.backgroundColor = .white

        tableView.tableFooterView = footerView
        self.tableView.backgroundColor = .white
    }

    func getTasks() {
        realm = try! Realm()
        taskList = [Task]()
        let result = realm.objects(Task.self)
    
        for task in result {
            taskList.append(task)
        }
        tableView.reloadData()
    }

    //MARK: Search Delegate

    func updateSearchResults(for searchController: UISearchController) {

        guard searchController.searchBar.text != nil else {

            searchedTasks = taskList

            self.tableView.reloadData()

            return
        }

        if !(searchController.searchBar.text!.isEmpty) {

            searchedTasks = taskList.filter {

                $0.name.contains(searchController.searchBar.text!)
            }

        } else {

            searchedTasks = taskList
        }

        self.tableView.reloadData()
    }


    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(taskList.count == 0) {

            let noResultLabel = UILabel(frame: tableView.bounds)
            noResultLabel.textColor = UIColor(white: 60.0 / 255.0, alpha: 1)
            noResultLabel.numberOfLines = 0
            noResultLabel.textAlignment = NSTextAlignment.center
            noResultLabel.font = noResultLabel.font.withSize(14)
            noResultLabel.text = "There's no task saved.\n Press the + button to create one!"
            noResultLabel.textColor = lightBlueColor
            noResultLabel.sizeToFit()

            tableView.backgroundView = noResultLabel

            self.tableView.isHidden = false

        } else {

            tableView.backgroundView = nil
        }

        return taskList.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell

        let data = searchController.isActive ? searchedTasks : taskList

        let task = data[indexPath.row]

        cell.bind(task)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let data = searchController.isActive ? searchedTasks : taskList

        let task = data[indexPath.row]

        if tableView.isEditing {

            cell.setSelected(searchedTasks.contains(task), animated: false)

            if searchedTasks.contains(task) {

                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)

            } else {

                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let data = searchController.isActive ? searchedTasks : taskList

        if(tableView.isEditing) {

            if !searchedTasks.contains(data[indexPath.row]) {

                searchedTasks.append(data[indexPath.row])
            }

            self.navigationItem.rightBarButtonItem?.isEnabled = searchedTasks.count > 0

        } else {

//            performSegue(withIdentifier: "editTask", sender: indexPath)

            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let data = searchController.isActive ? searchedTasks : taskList

        searchedTasks = searchedTasks.filter {

            $0.name != data[indexPath.row].name
        }

        if tableView.isEditing {

//            self.navigationItem.rightBarButtonItem?.isEnabled = searchedTasks.count > 0
        }

    }

    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        return 80
    //    }


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: {

            let data = self.searchController.isActive ? self.searchedTasks : self.taskList

            let task = data[$1.row]

            let yesHandler: ((UIAlertAction) -> Void) = { (action) in
//            DELETE TASK
                try! realm.write {
                    realm.delete(task)
                }
            }



            presentYesNoAlert(title: "Are you sure you want to delete that Task?", message: " \(task.name)? \nWill be deleted forever!", view: self, yesHandler: yesHandler, noHandler: nil)
        })

        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: {

//            let data = self.searchController.isActive ? self.searchedTasks : self.taskList

//            let task = data[$1.row]

            self.selectedRow = $1.row

            self.performSegue(withIdentifier: "editTask", sender: nil)
        })

        return [delete, edit]
    }

    //     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //         if editingStyle == .delete {

    //             let alertController = UIAlertController(title: "Warning!", message: "Are you sure you want to delete this Task?", preferredStyle: UIAlertControllerStyle.alert)

    //             let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
    //             {
    //                 (result: UIAlertAction) -> Void in
    // //                self.deleteOccurrence(index: indexPath)
    //             }


    //             let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
    //             {
    //                 (result: UIAlertAction) -> Void in
    //                 print("You pressed Cancel")
    //             }

    //             alertController.addAction(cancelAction)
    //             alertController.addAction(okAction)
    //             self.present(alertController, animated: true, completion: nil)
    //             //            objects.remove(at: indexPath.row)
    //             //            tableView.deleteRows(at: [indexPath], with: .fade)
    //         }
    //         //        else if editingStyle == .insert {
    //         //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    //         //        }
    //     }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "editTask":

                let data = searchController.isActive ? searchedTasks : taskList

                let task = data[selectedRow]
                self.selectedRow = -100
                
                let destination = segue.destination as! DetailsViewController
                destination.task = task
                destination.isEditingTask = true
                destination.parentView = self
                break
                
            default:
                break
            }


        }
    }
}

func presentYesNoAlert(title: String, message: String, view: UIViewController, yesHandler: ((UIAlertAction) -> Void)?, noHandler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: yesHandler)

    let noAction = UIAlertAction(title: "No", style: .cancel, handler: noHandler)

    alertController.addAction(yesAction)

    alertController.addAction(noAction)

    view.present(alertController, animated: true, completion: nil)
}
