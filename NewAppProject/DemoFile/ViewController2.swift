//
//  ViewController2.swift
//  NewAppProject
//
//  Created by NT 2 on 25/04/23.
//

import UIKit

class ViewController2: UIViewController,DatePickerDelegate2 {
   

    @IBOutlet var inputTF: UITextField!
    
    let datePicker2 = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let firstViewController =  ViewController1()
        firstViewController.datePickerDelegate = self

    }
    func datePickerValueChanged(date: Date) {
        datePicker2.date = date
    }
    
}
extension ViewController2 : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if textField.tag == 2{ //birthDate picker open
            openDateDatePicker()
        }
        
    }
    
    func openDateDatePicker(){
        datePicker2.preferredDatePickerStyle = .wheels
        inputTF.inputView = datePicker2
        datePicker2.datePickerMode = .date

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
       
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        inputTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneDateBtnClicked(){
        //this is for selected date pass in edit Profile screen
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        inputTF.text = formatter.string(from: datePicker2.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}
