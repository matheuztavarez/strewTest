//
//  DetailsViewController.swift
//  strewTest
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit
import DateTimePicker

class DetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectDateButton(_ sender: Any) {
        selectDate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func selectDate() {
        
        let picker = DateTimePicker.show()
        picker.highlightColor = lightBlueColor
    
        picker.completionHandler = { date in
            // do something after tapping done
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 140 // Bool
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        
//        if(text == "\n") {
//            
//            nameTextField.resignFirstResponder()
//            
//            return false
//        }
//        
//        return true
//    }
    
}

