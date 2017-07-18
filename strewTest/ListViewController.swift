//
//  ViewController.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//
import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskList = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func tableViewSetup(){
        let footerView = UIView(frame: CGRect.zero)
        footerView.backgroundColor = .white
        
        tableView.tableFooterView = footerView
        self.tableView.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
//        cell.nameLabel.textAlignment = .left
//        cell.downloadButtonOutlet.isHidden = false
//        cell.documentImage.isHidden = false
//        let document = documentList[indexPath.row]
//        cell.document = document
//        cell.view = self
//        cell.nameLabel.text = document.title!
//        
//        cell.documentImage.image = UIImage(named: "pdfDocument")?.maskWithColor(color: UIColor(red: 1.0 / 255.0, green: 140.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0))
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 80
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == documentList.count - 3 {
//            if(nextPage != "") {
//                self.loadNextPage()
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "OutKey", message: "Tem certeza que deseja deletar essa ocorrência?", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Sim", style: UIAlertActionStyle.default)
            {
                (result: UIAlertAction) -> Void in
//                self.deleteOccurrence(index: indexPath)
            }
            
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel)
            {
                (result: UIAlertAction) -> Void in
                print("You pressed Cancel")
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            //            objects.remove(at: indexPath.row)
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //        else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        //        }
    }

}

