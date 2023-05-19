//
//  ChangePasswordVC.swift
//  NewAppProject
//
//  Created by NT 2 on 20/03/23.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet var popupVIew: UIView!
    @IBOutlet var oldPasswordTF: UITextField!
    @IBOutlet var newPasswordTF: UITextField!
    @IBOutlet var conformPasswordTF: UITextField!
    @IBOutlet var updatePasswordBtn: UIButton!
    
    var user_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        popupVIew.alpha = 0
        updatePasswordBtn.layer.cornerRadius = 20
        textFieldDesign()
        dropShadow()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewWillAppear(true)
        popupVIew.alpha = 1
    }
    func textFieldDesign(){
        
        oldPasswordTF.setBottomBorder(color: "#3EFE46")
        conformPasswordTF.setBottomBorder(color: "#3EFE46")
        newPasswordTF.setBottomBorder(color: "#3EFE46")
    }
    
    //MARK: - receiving userdata from userdefault
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
// MARK: - Update Password Btn Clicked Action
    
    @IBAction func updatePasswordBtnClicked(_ sender: UIButton) {
        
        //cheking Old password
        let OldPass = DataBaseManager.shared.matchOldPassword(userId: self.user_id, strOldPass: self.oldPasswordTF.text!)
        
        if self.oldPasswordTF.text! == "" && self.newPasswordTF.text!=="" && self.conformPasswordTF.text!==""
        {
            self.createAlert(strAlert: "Please fill all Data")
        }
        else if self.oldPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter OldPassword ")
        }
        else if isValidPassword(testStr: oldPasswordTF.text!) ==  false
        {
            self.createAlert(strAlert: "OldPassword must be at least 8 letter")
        }else if self.newPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter NewPassword ")
        }
        else if isValidPassword(testStr: newPasswordTF.text!) ==  false
        {
            self.createAlert(strAlert: "NewPassword must be at least 8 letter")
        }
        else if self.conformPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter confirmPassword")
        }
        else if !OldPass{
            self.createAlert(strAlert: "OldPassword does not match")
        }
        else if isValidPassword(testStr: conformPasswordTF.text!) ==  false
        {
            self.createAlert(strAlert: "ConfirmPassword must be at least 8 letter")
        }
        else if newPasswordTF.text! != conformPasswordTF.text!
        {
            self.createAlert(strAlert: "confirmPassword does not match")
        }
       else{
            
            
            let loader = self.loader()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){ //time delay
                
                //MARK:- update passwordc call in Database
                
                let result = DataBaseManager.shared.chageUserPassword(userId: self.user_id, strOldPass: self.oldPasswordTF.text!, strNewPass: self.newPasswordTF.text!)
                
                if result{ // if it's true then dismis popup view
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.createAlert(strAlert: "Password does not updated")
                }
                
                self.stopLoad(loader: loader)
                self.dismiss(animated: true, completion: nil)
            }
    
        }

    }
    
}

//MARK: - Maximum Password charactor or data in textfield delegate

extension ChangePasswordVC:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            //maximum character in password
            let updateText = currentText.replacingCharacters(in: stringRange, with: string)
            
            return updateText.count <= 8
    }
}

//MARK: - Loader code (Activity indicator)
extension ChangePasswordVC{
    
    //MARK:- Activity Indicator Loading Start

    func loader()->UIAlertController{
        let alert = UIAlertController(title: "\t"+""+"Updating New Password", message:"Please wait...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 10, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
        
    }
    
//MARK:- Activity Indicator Loading stop
    
    func stopLoad(loader:UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
extension ChangePasswordVC{
    
    //Right Corner three dot btn tap popup view manu shadow
    
    func dropShadow() {
        popupVIew.layer.cornerRadius = 30
        popupVIew.layer.masksToBounds = false
        popupVIew.layer.shadowColor = UIColor.black.cgColor
        popupVIew.layer.shadowOpacity = 0.9
        popupVIew.layer.shadowOffset = .zero
        popupVIew.layer.shadowRadius = 5
        popupVIew.layer.shouldRasterize = true
    }
    
    // MARK:- UserDefault data filled in Textfields here.
    
            func getData(){
                getDataFromDefaults { success, id, firstname, lastname, email, password, mobileno,dateofbirth,birthtime,country,state,city,gender,aboutme,imgUrl  in
                    
                            if success == true {
                                self.user_id = id
                            }else {
                                //No data found
                            }
               }
          }
    
}
