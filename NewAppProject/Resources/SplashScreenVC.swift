//
//  SplashScreenVC.swift
//  NewAppProject
//
//  Created by MacbookAir_32 on 29/05/23.
//

import UIKit

//class SplashScreenVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//}


class SplashScreenVC: UIViewController {

    @IBOutlet var swiftLogoImg: UIImageView?
    
    @IBOutlet weak var imgwelcome: UIImageView?
    //  @IBOutlet var welcomeImg: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.swiftLogoImg?.alpha = 0
       // self.welcomeImg?.alpha = 0
        self.imgwelcome?.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            self.animateLabelAndImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToNextScreen()
        }
    }
    
    func animateLabelAndImage() {
        UIView.animate(withDuration: 3.0, animations: {
            self.swiftLogoImg?.alpha = 1
            self.swiftLogoImg?.transform = CGAffineTransform(translationX: 0, y: 0)
            self.swiftLogoImg?.clipsToBounds = true
        }) { (_) in
            self.swiftLogoImg?.isHidden = false
        }
        UIView.animate(withDuration: 3.0, animations: {
            self.imgwelcome?.alpha = 1
            self.imgwelcome?.transform = CGAffineTransform(translationX: 0, y: 0)
            self.imgwelcome?.clipsToBounds = true
        }) { (_) in
            self.imgwelcome?.isHidden = false
        }

    }
    
    private func navigateToNextScreen() {
        if UserDefaults.standard.bool(forKey: "rememberMe") {
            let myTabbar = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControl") as! TabBarControl
            navigationController?.pushViewController(myTabbar, animated: false)
            
        } else {
            let myLogin = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! Login
            self.navigationController?.pushViewController(myLogin, animated: false)
        }
    }
}
