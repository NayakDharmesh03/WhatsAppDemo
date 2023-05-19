//
//  GlobelViewController.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 24/03/23.
//

import UIKit

class GlobelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
extension UIViewController{
    
    // MARK:- Globle Alert massage
   @objc func createAlert(strAlert : String)
    {
        let alert = UIAlertController(title: "Message" , message:strAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK:- create alert tap on ok then navigate another screen
    @objc func createAlertAndNavigate(strAlert : String){
        let alert = UIAlertController(title: "Message" , message:strAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
      }))
        self.present(alert, animated: true, completion: nil)
    }
    
// MARK:- Globle Validation regex
    
    //email regex
   @objc func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[a-z_]+[0-9a-z._-]+@[a-z0-9-]+\\.[a-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //Password regex
    @objc func isValidPassword(testStr:String) -> Bool {
        let passwordRegex = "[A-Z0-9a-z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: testStr)
    }
    //phone no regex
    @objc func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[0-9]{10,}$"

        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: testStr)
    }
    //name regex
    @objc func isValidName(testStr:String) -> Bool {
        let nameRegEx = "^[A-Z]{1}[a-z]+[ ]{1}[A-Z]{1}[a-z]+${24,}"

        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: testStr)
    }
}

//MARK:- For Toast massage code using UILabel
extension UIViewController {

    func showToast(message : String, font: UIFont) {

            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
}
//MARK:- For drop down icon in textField
enum TextFieldImageSide {
    case left
    case right
}

extension UITextField {
    func setUpImage(imageName: String, on side: TextFieldImageSide) {
        let button = UIButton(frame: CGRect(x: -15, y: 3, width: 15, height: 10))
        button.tintColor = .black
        if let imageWithSystemName = UIImage(systemName: imageName) {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        } else {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }

        button.addTarget(self, action: #selector(downArrowTapped), for: .touchUpInside)
        let downArrobtn = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        downArrobtn.addSubview(button)

        switch side {
        case .left:
            leftView = downArrobtn
            leftViewMode = .always
        case .right:
            rightView = downArrobtn
            rightViewMode = .always
        }
    }
    @objc func downArrowTapped() {
        // Handle the tap of the down arrow button here
        print("Down arrow tapped")
    }
}

//MARK:- This is share Activity button mathod
extension UIViewController{
    
    //here we can pass anything
    func shareButtonActivity(Contant:Any){

        //if you want to open App stor then this below
//        if let url = URL(string: "https://www.apple.com/in/app-store/") {
//            UIApplication.shared.open(url)
//        }
//
        let activityVC = UIActivityViewController(activityItems: [Contant], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    //this is for opening mail app
    func contactusMail(){
        
        let supportEmail = "abc@xyz.com"
        if let emailURL = URL(string: "mailto:\(supportEmail)"), UIApplication.shared.canOpenURL(emailURL)
        {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
        
    }
}
