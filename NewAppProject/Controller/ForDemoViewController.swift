//
//  ForDemoViewController.swift
//  NewAppProject
//
//  Created by NT 2 on 04/04/23.
//

import UIKit

class ForDemoViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var inputTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.openDatePicker(inputTF: inputTF)
    }
    func openDatePicker(inputTF:UITextField){
        
        // Create a date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        // Create a toolbar with a "Done" button to dismiss the date picker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneBtn], animated: false)

        // Create a container view that will hold the date picker and toolbar
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 244))
        containerView.addSubview(datePicker)
        containerView.addSubview(toolbar)

        // Set the container view as the input view of the text field
        inputTF.inputView = containerView

    }
    @objc func doneBtnClick(inputDateTF:UITextField){
        if let datePicker = inputDateTF.inputView as? UIDatePicker{
            let dateFormet = DateFormatter()
            dateFormet.dateStyle = .medium
            dateFormet.timeStyle = .none
            inputDateTF.text = dateFormet.string(for: datePicker.date)
            
            print("Done",datePicker.date)
        }
        inputDateTF.resignFirstResponder()

    }
}


