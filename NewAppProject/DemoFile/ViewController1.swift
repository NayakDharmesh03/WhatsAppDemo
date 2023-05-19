//
//  ViewController1.swift
//  NewAppProject
//
//  Created by NT 2 on 25/04/23.
//

import UIKit

protocol DatePickerDelegate2: class {
    func datePickerValueChanged(date: Date)
}

class ViewController1: UIViewController {

    weak var datePickerDelegate: DatePickerDelegate2?

    @IBOutlet var inputTF: UITextField!
    let datePicker1 = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func setDate(_ sender: UIButton) {
       
        let nextVC = self.storyboard?.instantiateViewController(identifier: "ViewController2") as! ViewController2
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension ViewController1 :UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if textField.tag == 1{ //birthDate picker open
            openDateDatePicker()
        }
        
    }
    
    func openDateDatePicker(){
        datePicker1.preferredDatePickerStyle = .wheels
        inputTF.inputView = datePicker1
        datePicker1.datePickerMode = .date
        datePickerDelegate?.datePickerValueChanged(date: datePicker1.date)
        datePicker1.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged) // We register the target function
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
       
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        inputTF.inputAccessoryView = toolBar
        
    }
    @objc func datePickerChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        inputTF.text = dateFormatter.string(from: sender.date)
//        print(strDate)
      }
    @objc func doneDateBtnClicked(){
        //this is for selected date pass in edit Profile screen
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        inputTF.text = formatter.string(from: datePicker1.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}
