//
//  ProfilePage.swift
//  NewAppProject
//
//  Created by NT 2 on 09/03/23.
//

import UIKit
import SideMenu
// MARK:- TextField Under line code
extension UITextField {
    
    func setBottomBorder(color:String) {
        self.borderStyle = UITextField.BorderStyle.none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(named: color)?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width*3, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
// MARK:- ProfilePage Controller Class
class ProfilePage: UITableViewController {
    
    var user_id = ""
    var strUrl = ""
    @IBOutlet weak var sideBar: UIBarButtonItem!
    var strGender:String = ""
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileLbl: UILabel!
    
    @IBOutlet var firstnameTextField: UITextField!
    @IBOutlet var lastnameTextFileld: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var mobileNoTextField: UITextField!
    
    @IBOutlet var dateOfbirthTF: UITextField!
    @IBOutlet var birthTimeTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var stateTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var genderTF: UITextField!
    
    @IBOutlet var aboutmeTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none

        textFieldDesign()
        addBottomLine()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 44
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0.01881233789, green: 0.1101799682, blue: 0.4214587212, alpha: 1)
        

    }
    
    // MARK:-  UserDefault getData Function called here.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getData()
        
    }

    @IBAction func showSideBar(_ sender: Any) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
                if UIDevice.current.userInterfaceIdiom == .pad{
                    vc.settings.menuWidth = self.view.frame.width - 200
                }else{
                    vc.settings.menuWidth = self.view.frame.width - 80
                }
                vc.settings.presentationStyle = .viewSlideOut
                vc.settings.statusBarEndAlpha = 0
                vc.leftSide = true
                present(vc, animated: true, completion: nil)
        
    }
   
    
    @IBAction func editProfileButtonClicked(_ sender: UIButton) {
        
//edit button click code
        let profileVC = self.storyboard?.instantiateViewController(identifier: "EditProfileData") as! EditProfileData
        
        self.navigationController?.pushViewController(profileVC, animated: true)
    
        
    }
    
    func addBottomLine(){
         // Create a new layer with the desired frame and properties
         let bottomLine = CALayer()
         bottomLine.frame = CGRect(x: 0, y: aboutmeTV.frame.height - 1, width: aboutmeTV.frame.width*3, height: 1)
         bottomLine.backgroundColor = UIColor.black.cgColor

         // Add the layer as a sublayer of the text view's layer
         aboutmeTV.layer.addSublayer(bottomLine)
     }
    
    func textFieldDesign(){
        
        firstnameTextField.setBottomBorder(color: "#3EFE46")
        lastnameTextFileld.setBottomBorder(color: "#3EFE46")
        emailTextField.setBottomBorder(color: "#3EFE46")
        mobileNoTextField.setBottomBorder(color: "#3EFE46")
        
        dateOfbirthTF.setBottomBorder(color: "#3EFE46")
        birthTimeTF.setBottomBorder(color: "#3EFE46")
        countryTF.setBottomBorder(color: "#3EFE46")
        stateTF.setBottomBorder(color: "#3EFE46")
        cityTF.setBottomBorder(color: "#3EFE46")
        genderTF.setBottomBorder(color: "#3EFE46")
    }


}

extension ProfilePage{
    
    func documentsDir(strUrl:String) {
            if let url = URL(string: strUrl) {
                    print(url)
                    let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                    let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent(url.lastPathComponent)
                let fullDestPathString = fullDestPath!.path
                self.profileImage.image = UIImage(contentsOfFile: fullDestPathString)
            
            } else {
                print("Invalid URL")
            }
       
    }
    
    // MARK:- UserDefault data filled in Textfields here.
            func getData(){
                
                getDataFromDefaults { success, id, firstname, lastname, email, password, mobileno,dateofbirth,birthtime,country,state,city,gender,aboutme,imgUrl    in
                    
                            if success == true {
                                
                                self.firstnameTextField.text = firstname
                                self.lastnameTextFileld.text = lastname
                                self.emailTextField.text = email
                                self.mobileNoTextField.text = mobileno
                                
                                //new 
                                self.dateOfbirthTF.text = dateofbirth
                                self.birthTimeTF.text = birthtime
                                self.countryTF.text = country
                                self.stateTF.text = state
                                self.cityTF.text = city
                                self.genderTF.text = gender
                                
                                self.aboutmeTV.text = aboutme
                                self.user_id = id
                                self.documentsDir(strUrl: imgUrl)
                                
                            }else {
                                //No data found
                            }
            }
          }
    
}
extension ProfilePage : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
extension UITextView {
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x,
                              y: self.frame.origin.y+self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color
        self.superview!.insertSubview(border, aboveSubview: self)
    }
}
