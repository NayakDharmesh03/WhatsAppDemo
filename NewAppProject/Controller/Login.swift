//
//  Login.swift
//  NewAppProject
//
//  Created by Dharmesh Nayak on 08/03/23.
//

import UIKit
// MARK: - Login class viewController
class Login: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotpasswordBtn: UIButton!
    @IBOutlet weak var rememberMe: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var emailTf:UITextField!
    var stremail = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.textContentType = .none // Set to a different value or nil
        allControlsConfiguration()
        
        rememberMeButtonClicked()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
//
//        // Check if the "Remember Me" flag is set to true
//        if UserDefaults.standard.bool(forKey: "RememberMe") {
//                 // Skip the login screen and navigate to the home screen
//                 navigateToHomeScreen()
//        }
    }
    
    func allControlsConfiguration(){
        
        emailTextField.layer.cornerRadius = emailTextField.frame.height/2
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        
    }
    
    //MARK: - remember me radio button
    @IBAction func rememberMeButtonClicked(_ sender: UIButton) {
        rememberMe.isSelected = !rememberMe.isSelected

    }
    
    // Navigate to the main screen
    private func navigateToHomeScreen() {
        //Valid email & Password move next Screen
        let homeVC = self.storyboard?.instantiateViewController(identifier: "TabBarControl") as! TabBarControl
        self.navigationController?.pushViewController(homeVC, animated: true)
    }

    
    //MARK: - forgotPassword button Action Clicked
    
    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        varifyEmail()
        
    }
    
    //MARK: - SIGNUP Button Action Clicked
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        let signUPage = self.storyboard?.instantiateViewController(identifier: "SignUp") as! SignUpTableViewController
        
        self.navigationController?.pushViewController(signUPage, animated: true)
        
    }
    
    //MARK: - Login Button Action Clicked
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        let emailResult = DataBaseManager.shared.checkUserEmailisExitOrNot(strEmail: self.emailTextField.text!)
        
        let result = DataBaseManager.shared.userlogin(email:emailTextField.text!,pass:passwordTextField.text!)
        
        if self.emailTextField.text?.lowercased() == "" && self.passwordTextField.text!==""
        {
            self.createAlert(strAlert: "Please fill email and password")
        }
        else if self.emailTextField.text == ""{
            self.createAlert(strAlert: "Please enter email ")
        }
        else if isValidEmail(testStr: emailTextField.text!) ==  false
        {
            self.createAlert(strAlert: "Please Enter Valid email")
        }else if passwordTextField.text == ""{
            self.createAlert(strAlert: "Please enter password")
        }
        else if !emailResult{
            self.createAlert(strAlert: "This email does not exist")
        }
        else if !result{
            self.createAlert(strAlert: "Password does not match")
        }
        else
        {
            
            // Authenticate the user's credentials
            if result {
                // Navigate to the main screen
                //Valid email & Password move next Screen
                let homeVC = self.storyboard?.instantiateViewController(identifier: "TabBarControl") as! TabBarControl
                self.navigationController?.pushViewController(homeVC, animated: true)
                
                if rememberMe.isSelected == true{
                    let user_Defaults = UserDefaults.standard
                    user_Defaults.set(rememberMe.isSelected, forKey: "rememberMe")
                }else{
                    let user_Defaults = UserDefaults.standard
                    user_Defaults.set(rememberMe.isSelected, forKey: "rememberMe")
                }
               
                
            } else {
                // Display an error message to the user
                createAlert(strAlert: "This user does not exist")
            }
            
            
            
        }
        
        
    }
}


//MARK: - textfield delegate for email in lowercase and pass max 8

extension Login:UITextFieldDelegate{
    //maximum charactor or data in textfield
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //        if textField.tag == 1{
        //            // Convert the replacement string to lowercase
        //            let lowerCaseString = string.lowercased()
        //
        //            // Create a new string by replacing the entered text with the lowercase string
        //            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: lowerCaseString)
        //            // Update the text field with the new string
        //            textField.text = newString
        //            // Return false to prevent the default behavior of the text field
        //            return false
        //
        //            //this is for password max length
        //        }else
        if textField.tag == 2{
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            //maximum character in password
            let updateText = currentText.replacingCharacters(in: stringRange, with: string)
            
            
            if textField.tag == 2{
                return updateText.count <= 8
            }
            
        }
        
        return true
        
    }
}
//MARK: - if Remember Me Button Is Selected Then Automatically Send On Profile Image
extension Login{
    
    
    func rememberMeButtonClicked(){
        
         let user_Defaults = UserDefaults.standard

             if user_Defaults.bool(forKey: "rememberMe") {
             let storyboard = UIStoryboard(name: "Main", bundle: nil)

             let homeVC = self.storyboard?.instantiateViewController(identifier: "TabBarControl") as! TabBarControl
             self.navigationController?.pushViewController(homeVC, animated: true)

         }
        
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        dictionary.keys.forEach{ key in
            
            defaults.removeObject(forKey: key)
        }
    }
}



//MARK: - varifing email
extension Login {
    
    func varifyEmail(){
        
        let alerBox = UIAlertController(title: "Varify email it's you", message: "", preferredStyle: .alert)
        let update = UIAlertAction(title: "Varify", style: .default) { [self] (action) in
            
            if self.emailTf!.text == ""
            {
                self.createAlert(strAlert: "Please fill email")
            }
            else if self.emailTf.text == ""{
                self.createAlert(strAlert: "Please enter email ")
            }
            else if isValidEmail(testStr: (emailTf?.text!)! ) ==  false
            {
                self.createAlert(strAlert: "Please Enter Valid email")
            }
            else
            {
                let loader = self.loader()
                self.stremail = emailTf.text!
                let result = DataBaseManager.shared.checkUserEmailisExitOrNot(strEmail: emailTf!.text!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    
                    if result
                    {
                        
                        print("GO next VC")
                        
                        //                        let story = UIStoryboard(name: "Main", bundle: nil)
                        let nextVC = self.storyboard?.instantiateViewController(identifier: "PasswordUpdateVC") as! PasswordUpdateVC
                        
                        nextVC.email = self.stremail
                        self.addChild(nextVC)
                        self.view.addSubview(nextVC.view)
                        nextVC.didMove(toParent: self)
                        
                    }else{
                        self.showToast(message: "Email does not Found...!", font: .systemFont(ofSize: 12.0))
                        
                    }
                    
                    self.stopLoad(loader: loader)
                }
                
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Edit option cancel by user")
        }
        
        alerBox.addAction(update)
        alerBox.addAction(cancel)
        alerBox.addTextField { (textfield) in
            
            //this text field for alert box email
            textfield.font = UIFont.systemFont(ofSize: 20) // Set the desired font size
            self.emailTf = textfield
            self.emailTf?.placeholder = "Enter email"
        }
        self.present(alerBox, animated: true, completion: nil)
    }
}

//MARK: - Loader code (Activity indicator)
extension Login{
    
    //Starting Loader
    func loader()->UIAlertController{
        let alert = UIAlertController(title: " Fetching your email...", message: "Loading...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 10, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
        
    }
    
    //stoping Loader
    func stopLoad(loader:UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}


