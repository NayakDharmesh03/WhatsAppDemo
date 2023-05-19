//
//  TabBarControl.swift
//  NewAppProject
//
//  Created by NT 2 on 28/03/23.
//

import UIKit

class TabBarControl: UITabBarController {

    @IBOutlet var mytabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mytabBar.layer.masksToBounds = true
//        mytabBar.layer.cornerRadius = mytabBar.frame.height/2
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "HomeSegue" {
                let HomeScreen = segue.destination as! HomeScreenVC
                // pass any necessary data to the second view controller here
            }else if segue.identifier == "homeWorkoutSegue"{
                
            }else if segue.identifier == "whatsappSegue"{
                
            }else if segue.identifier == "profileSegue"{
                
            }
        }



}
