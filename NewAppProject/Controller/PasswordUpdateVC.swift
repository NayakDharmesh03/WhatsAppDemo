//
//  PasswordUpdateVC.swift
//  NewAppProject
//
//  Created by NT 2 on 24/03/23.
//

import UIKit


class PasswordUpdateVC: UIViewController {

    @IBOutlet var popupView: UIView!
    @IBOutlet var newPasswordTF: UITextField!
    @IBOutlet var conformPassTF: UITextField!
    @IBOutlet var updateBtn: UIButton!
    
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        addAanimation()
        updateBtn.layer.cornerRadius = 20
        textFieldDesign()
        
    }
    
    func textFieldDesign(){
        
        conformPassTF.setBottomBorder(color: "#3EFE46")
        newPasswordTF.setBottomBorder(color: "#3EFE46")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.removeAanimation()
        self.dismiss(animated: true, completion: nil)
    }
    //MARK:- Update password validation
    
    @IBAction func updatePassword(_ sender: UIButton) {
        
        if newPasswordTF.text == "" && conformPassTF.text == ""
        {
            self.createAlert(strAlert: "Please fill all data")
        }
        else if self.newPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter new password ")
        }
        else if isValidPassword(testStr:newPasswordTF.text!) == false
        {
            self.createAlert(strAlert: "Password must be at least 8 letter")
            
        }
        else if self.conformPassTF.text == ""{
            self.createAlert(strAlert: "Please enter confirmpassword ")
        }
        else if isValidPassword(testStr:conformPassTF.text!) == false
        {
            self.createAlert(strAlert: "Password must be at least 8 letter")
            
        }
        else if newPasswordTF.text! != conformPassTF.text!
        {
            self.createAlert(strAlert: "Password does not match")
        }
        else{
            let loader = self.loader()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){ //time delay
                
                //MARK:- update passwordc call in Database
                
                let isUpdated = DataBaseManager.shared.UpdateForgotPassword(strEmail: self.email, strNewPassword: self.newPasswordTF.text!)
                
                if isUpdated{ // if it's true then dismis popup view
                    self.dismiss(animated: true, completion: nil)
                    self.showToast(message: "Password Updated successfully.", font: .systemFont(ofSize: 12.0))
                    self.removeAanimation()
                }
                else{
                    self.showToast(message: "Password does not Updated", font: .systemFont(ofSize: 12.0))
                }
                
                self.stopLoad(loader: loader)
            }
            
        }
    }
}
extension PasswordUpdateVC:UITextFieldDelegate{
    
    //maximum password charactor or data in textfield delegate
    
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
extension PasswordUpdateVC{
    
    //MARK:- Activity Indicator Loading start
    
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
    
    //MARK:- shadow of popup view
    
    func dropShadow() {
        
        popupView.layer.masksToBounds = false
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 0.9
        popupView.layer.shadowOffset = .zero
        popupView.layer.shadowRadius = 5
        popupView.layer.shouldRasterize = true
    }
    
    //MARK:- add animation of popup view
    
    func addAanimation(){
       
        self.popupView.transform = CGAffineTransform(translationX: 0, y: self.popupView.frame.height)
        UIView.animate(withDuration: 0.9,animations:{
            self.popupView.transform = .identity
        })

    }
    //MARK:- remove animation of popup view
    
    func removeAanimation(){
        self.popupView.transform = .identity
        UIView.animate(withDuration: 0.5,animations:{
            self.popupView.transform = CGAffineTransform(translationX: 0, y: self.popupView.frame.height)
        }){ complete in
            self.view.removeFromSuperview()
        }

    }
}
