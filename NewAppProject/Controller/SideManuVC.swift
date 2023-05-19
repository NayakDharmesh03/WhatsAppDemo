//
//  SideManuVC.swift
//  NewAppProject
//
//  Created by NT 2 on 11/04/23.
//

import UIKit

class SideManuVC: UIViewController {

    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var mobileNoLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var changePasswordBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet var sideManuView: UIView!
    
    var manuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.shouldRasterize = true
        
        
            logOutBtn.layer.cornerRadius = logOutBtn.frame.height/2
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.layer.masksToBounds = true
            profileImage.layer.borderColor = UIColor.white.cgColor
            profileImage.layer.borderWidth = 1
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Change this to .default for black text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    @IBAction func editProfileBtnClicked(_ sender: UIButton) {
        let editVC = self.storyboard?.instantiateViewController(identifier: "EditProfileData") as! EditProfileData
        self.navigationController?.pushViewController(editVC, animated: false)
        
    }
    @IBAction func changePasswordBtnClicked(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        
        //this is for change password controller present in full screen
                controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .coverVertical
//                controller.u_Id = self.user_id
                self.present(controller, animated: false)
        
    }
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        
        let masage = "www.google.com" //this for what we want to share and pass this contant in mathod
        
        shareButtonActivity(Contant: masage) //this is globle function this is declared in Globel UIViewController
    }
    @IBAction func contactUsBtnClicked(_ sender: UIButton) {
        contactusMail() //this is globle function this is declared in Globel UIViewController it navigat in email
    }
    
    //MARK:- LOGOUT Button Action
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
       
        let user_defaults = UserDefaults.standard
        user_defaults.removeObject(forKey: "username")
        user_defaults.removeObject(forKey: "password")
        user_defaults.set(false, forKey: "rememberMe")

        //Back Login Screen
        let backToLoginVC = self.storyboard?.instantiateViewController(identifier: "initController") as! Login
        backToLoginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(backToLoginVC, animated: true)
    }
    
}
extension SideManuVC{
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
                            
                            self.nameLabel.text = firstname
                            self.mobileNoLabel.text = mobileno
                            self.documentsDir(strUrl: imgUrl)
                            
                        }else {
                            //No data found
                        }
        }
      }
}
